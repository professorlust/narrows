module CharacterCreationApp.Views exposing (..)

import Html exposing (Html, main_, h1, h2, div, form, input, label, button, ul, li, a, text)
import Html.Attributes exposing (id, class, href, type_, placeholder, for, value)
import Html.Events exposing (onInput)
import Common.Views exposing (onPreventDefaultClick, linkTo, breadcrumbNavView)
import CharacterCreationApp.Messages exposing (..)
import CharacterCreationApp.Models exposing (..)


mainView : Model -> Html Msg
mainView model =
    main_ [ id "narrator-app"
          , class "app-container app-container-simple"
          ]
        [ breadcrumbNavView
            NavigateTo
            [ { title = "Home"
              , url = "/"
              }
            , case model.narration of
                Just narration ->
                  { title = narration.title
                  , url = "/narrations/" ++ (toString narration.id)
                  }
                Nothing ->
                  { title = "…"
                  , url = "#"
                  }
            ]
            (text "New character")
        , h1 [] [ text "New character" ]
        , form [ class "narrow-form vertical-form" ]
            [ div [ class "form-line" ]
                [ label [] [ text "Name:" ]
                , input [ type_ "text"
                        , placeholder "Name"
                        , value model.characterName
                        , onInput UpdateName
                        ]
                    []
                ]
            , div [ class "form-line" ]
                [ label [ for "email" ] [ text "Email:" ]
                , input [ id "email"
                        , type_ "text"
                        , placeholder "Email"
                        , value model.playerEmail
                        , onInput UpdateEmail
                        ]
                    []
                ]
            , div [ class "btn-bar" ]
                [ button
                    [ class "btn btn-default"
                    , onPreventDefaultClick CreateCharacter
                    ]
                    [ text "Create" ]
                , button
                    [ class "btn"
                    , onPreventDefaultClick CancelCreateCharacter
                    ]
                    [ text "Cancel" ]
                ]
            ]
        ]
