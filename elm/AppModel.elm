module AppModel exposing (..)

import AnyModel exposing (..)
import Dict exposing (Dict)
import IdGenerator as IdGenerator
import Maybe
import Tuple exposing (..)


type alias ParentNode =
    { node : AnyModel
    , children : List AnyModel --edge not node
    }


type alias AppModel =
    { counter : Int
    , nodes : Dict String ParentNode
    , crumbs : List String
    }


rootNode : ParentNode
rootNode =
    { node = createAnyModel "root" DocumentWidget
    , children = []
    }


reset : AppModel
reset =
    { counter = 1
    , nodes = Dict.fromList [ ( "root", rootNode ) ]
    , crumbs = []
    }


getNode : AppModel -> String -> Maybe ParentNode
getNode appModel nodeId =
    Dict.get nodeId appModel.nodes


addNode : AppModel -> String -> WidgetType -> AppModel
addNode appModel parentId widgetType =
    let
        counter =
            appModel.counter + 1

        newId =
            IdGenerator.create widgetType counter

        newNode =
            { node = createAnyModel newId widgetType
            , children = []
            }

        childEdge =
            createAnyModel newId widgetType

        newNodes =
            appModel.nodes |> Dict.insert newId newNode |> Dict.update parentId (Maybe.map (\p -> { p | children = childEdge :: p.children }))
    in
    { counter = counter
    , nodes = newNodes
    , crumbs = appModel.crumbs
    }


{-| Attach a new child edge to a node
-}
linkNode : AppModel -> String -> String -> AppModel
linkNode appModel parentId nodeId =
    let
        widgetType =
            Dict.get nodeId appModel.nodes |> Maybe.map .node |> Maybe.map .widgetType |> Maybe.withDefault DocumentWidget

        childEdge =
            createAnyModel nodeId widgetType

        newNodes =
            appModel.nodes |> Dict.update parentId (Maybe.map (\p -> { p | children = childEdge :: p.children }))
    in
    { appModel | nodes = newNodes }


{-| internal - delete linked node in child
-}
removeChildrenLink : ParentNode -> String -> ParentNode
removeChildrenLink parentNode nodeId =
    { parentNode | children = parentNode.children |> List.filter (\edge -> edge.id /= nodeId) }


{-| Detach a child edge from a node
-}
unlinkNode : AppModel -> String -> String -> AppModel
unlinkNode appModel parentId nodeId =
    { appModel | nodes = Dict.update parentId (Maybe.map (\p -> removeChildrenLink p nodeId)) appModel.nodes }


{-| internal
-}
deletedNodeLinks : String -> Dict String ParentNode -> Dict String ParentNode
deletedNodeLinks nodeId nodes =
    Dict.toList nodes |> List.map (\duo -> mapSecond (\pn -> removeChildrenLink pn nodeId) duo) |> Dict.fromList


{-| Delete a node including all the relationships linking to that node
-}
deleteNode : AppModel -> String -> AppModel
deleteNode appModel nodeId =
    { appModel | nodes = Dict.remove nodeId appModel.nodes |> deletedNodeLinks nodeId }
