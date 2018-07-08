module FormBuilder exposing (createWidgetForm)

import AnyModel exposing (FieldInfoType(..), FieldType, WidgetType, getFieldInfo, getSupportedFieldTypes)
import Html exposing (..)
import Html.Attributes exposing (..)
import List


createField : FieldType -> Html msg
createField fieldType =
    let
        infoType =
            getFieldInfo fieldType |> .infoType
    in
    case infoType of
        NumberText ->
            createNumberField fieldType

        EnumText ->
            createDropdownField fieldType

        TagSet ->
            createTagsField fieldType

        other ->
            createLabelField fieldType


createLabelField : FieldType -> Html msg
createLabelField fieldType =
    let
        fieldInfo =
            getFieldInfo fieldType
    in
    div [ class "field" ]
        [ label [ class "label" ]
            [ text fieldInfo.label ]
        , div [ class "control" ]
            [ input [ class "input", type_ "text", maxlength 40 ]
                []
            ]
        , p [ class "help" ]
            [ text fieldInfo.hint ]
        ]


createNumberField : FieldType -> Html msg
createNumberField fieldType =
    let
        fieldInfo =
            getFieldInfo fieldType
    in
    div [ class "field" ]
        [ label [ class "label" ]
            [ text fieldInfo.label ]
        , div [ class "control" ]
            [ input [ class "input", type_ "number", Html.Attributes.min "0", Html.Attributes.max "10000" ]
                []
            ]
        , p [ class "help" ]
            [ text fieldInfo.hint ]
        ]


createDropdownField : FieldType -> Html msg
createDropdownField fieldType =
    let
        fieldInfo =
            getFieldInfo fieldType

        options =
            fieldInfo.suggestions |> List.map (\opt -> option [] [ text opt ])
    in
    div [ class "field" ]
        [ label [ class "label" ]
            [ text fieldInfo.label ]
        , div [ class "control" ]
            [ div [ class "select" ]
                [ select [] options
                ]
            ]
        , p [ class "help" ]
            [ text fieldInfo.hint ]
        ]


createTagsField : FieldType -> Html msg
createTagsField fieldType =
    let
        fieldInfo =
            getFieldInfo fieldType

        options =
            fieldInfo.suggestions |> List.map (\opt -> option [] [ text opt ])
    in
    div []
        [ div [ class "field" ]
            [ label [ class "label" ]
                [ text fieldInfo.label ]
            , div [ class "control" ]
                [ div [ class "select" ]
                    [ select [] options
                    ]
                ]
            , p [ class "help" ]
                [ text fieldInfo.hint ]
            ]
        , div [ class "tags has-addons" ]
            [ span [ class "tag is-danger" ]
                [ text "Alex Smith" ]
            , a [ class "tag is-delete" ]
                []
            ]
        ]


createWidgetForm : WidgetType -> Html msg
createWidgetForm widgetType =
    let
        supportedFields =
            getSupportedFieldTypes widgetType

        fields =
            supportedFields |> List.map createField
    in
    div [] fields
