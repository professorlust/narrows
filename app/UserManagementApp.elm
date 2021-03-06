module UserManagementApp exposing (..)

import Html exposing (Html)
import Core.Routes exposing (Route(..))
import UserManagementApp.Messages exposing (..)
import UserManagementApp.Models exposing (..)
import UserManagementApp.Update
import UserManagementApp.Views


type alias Model =
    UserManagementApp.Models.Model


type alias Msg =
    UserManagementApp.Messages.Msg


initialState : Model
initialState =
    { banner = Nothing
    , users = Nothing
    , userUi = Nothing
    , newUserEmail = ""
    , newUserIsAdmin = False
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update =
    UserManagementApp.Update.update


urlUpdate : Route -> Model -> ( Model, Cmd Msg )
urlUpdate =
    UserManagementApp.Update.urlUpdate


view : Model -> Html Msg
view =
    UserManagementApp.Views.mainView


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
