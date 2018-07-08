module App
  exposing(..)
{-| App

# Basics
@docs

-}

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import About as About
import AppModel exposing (..)
import FormBuilder
import AnyModel exposing (WidgetType(..))


main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }



-- MODEL


type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  }


model : Model
model =
  Model "" "" ""



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
  section [ class "section" ]
    [ 
      About.appHeader
      , div [ class "columns" ]
        [ div [ class "column" ]
          [About.appSearch]
        , div [ class "column" ]
          [FormBuilder.createWidgetForm MediumTextWidget]
        ]
      , About.appFooter
    ]


viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if model.password == model.passwordAgain then
        ("green", "OK")
      else
        ("red", "Passwords do not match!")
  in
    div [ style [("color", color)] ] [ text message ]
