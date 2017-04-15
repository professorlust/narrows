import Navigation

import Html.App as App
import Html exposing (Html, div, span, a, input, text, img, label, button, br)

import Routing
import ReaderApp
import CharacterApp
import NarratorDashboardApp
import NarrationCreationApp
import NarrationOverviewApp
import ChapterEditApp
import ChapterControlApp
import CharacterCreationApp

type alias Model =
  { route : Routing.Route
  , readerApp : ReaderApp.Model
  , characterApp : CharacterApp.Model
  , narratorDashboardApp : NarratorDashboardApp.Model
  , narrationCreationApp : NarrationCreationApp.Model
  , narrationOverviewApp : NarrationOverviewApp.Model
  , chapterEditApp : ChapterEditApp.Model
  , chapterControlApp : ChapterControlApp.Model
  , characterCreationApp : CharacterCreationApp.Model
  }

type Msg
  = NoOp
  | ReaderMsg ReaderApp.Msg
  | CharacterMsg CharacterApp.Msg
  | NarratorDashboardMsg NarratorDashboardApp.Msg
  | NarrationCreationMsg NarrationCreationApp.Msg
  | NarrationOverviewMsg NarrationOverviewApp.Msg
  | ChapterEditMsg ChapterEditApp.Msg
  | ChapterControlMsg ChapterControlApp.Msg
  | CharacterCreationMsg CharacterCreationApp.Msg


initialState : Result String Routing.Route -> (Model, Cmd Msg)
initialState result =
  combinedUrlUpdate result { route = Routing.NotFoundRoute
                           , readerApp = ReaderApp.initialState
                           , characterApp = CharacterApp.initialState
                           , narratorDashboardApp = NarratorDashboardApp.initialState
                           , narrationCreationApp = NarrationCreationApp.initialState
                           , narrationOverviewApp = NarrationOverviewApp.initialState
                           , chapterEditApp = ChapterEditApp.initialState
                           , chapterControlApp = ChapterControlApp.initialState
                           , characterCreationApp = CharacterCreationApp.initialState
                           }

combinedUrlUpdate : Result String Routing.Route -> Model -> (Model, Cmd Msg)
combinedUrlUpdate result model =
  let
    currentRoute = Routing.routeFromResult result
    (updatedReaderModel, readerCmd) = ReaderApp.urlUpdate currentRoute model.readerApp
    (updatedCharacterModel, characterCmd) = CharacterApp.urlUpdate currentRoute model.characterApp
    (updatedNarratorModel, narratorCmd) = ChapterEditApp.urlUpdate currentRoute model.chapterEditApp
    (updatedNarratorDashboardModel, narratorDashboardCmd) = NarratorDashboardApp.urlUpdate currentRoute model.narratorDashboardApp
    (updatedNarrationCreationModel, narrationCreationCmd) = NarrationCreationApp.urlUpdate currentRoute model.narrationCreationApp
    (updatedNarrationOverviewModel, narrationOverviewCmd) = NarrationOverviewApp.urlUpdate currentRoute model.narrationOverviewApp
    (updatedChapterControlModel, chapterControlCmd) = ChapterControlApp.urlUpdate currentRoute model.chapterControlApp
    (updatedCharacterCreationModel, characterCreationCmd) = CharacterCreationApp.urlUpdate currentRoute model.characterCreationApp
  in
    ( { model | route = currentRoute
              , readerApp = updatedReaderModel
              , characterApp = updatedCharacterModel
              , narratorDashboardApp = updatedNarratorDashboardModel
              , narrationCreationApp = updatedNarrationCreationModel
              , narrationOverviewApp = updatedNarrationOverviewModel
              , chapterEditApp = updatedNarratorModel
              , chapterControlApp = updatedChapterControlModel
              , characterCreationApp = updatedCharacterCreationModel
              }
    , Cmd.batch [ Cmd.map ReaderMsg readerCmd
                , Cmd.map CharacterMsg characterCmd
                , Cmd.map NarratorDashboardMsg narratorDashboardCmd
                , Cmd.map NarrationCreationMsg narrationCreationCmd
                , Cmd.map NarrationOverviewMsg narrationOverviewCmd
                , Cmd.map ChapterEditMsg narratorCmd
                , Cmd.map ChapterControlMsg chapterControlCmd
                , Cmd.map CharacterCreationMsg characterCreationCmd
                ]
    )

combinedUpdate : Msg -> Model -> (Model, Cmd Msg)
combinedUpdate msg model =
  case msg of
    ReaderMsg readerMsg ->
      let
        (newReaderModel, cmd) = ReaderApp.update readerMsg model.readerApp
      in
        ({ model | readerApp = newReaderModel }, Cmd.map ReaderMsg cmd)
    CharacterMsg characterMsg ->
      let
        (newCharacterModel, cmd) = CharacterApp.update characterMsg model.characterApp
      in
        ({ model | characterApp = newCharacterModel }, Cmd.map CharacterMsg cmd)
    NarratorDashboardMsg narratorDashboardMsg ->
      let
        (newNarratorDashboardModel, cmd) = NarratorDashboardApp.update narratorDashboardMsg model.narratorDashboardApp
      in
        ({ model | narratorDashboardApp = newNarratorDashboardModel }, Cmd.map NarratorDashboardMsg cmd)
    NarrationCreationMsg narrationCreationMsg ->
      let
        (newNarrationCreationModel, cmd) = NarrationCreationApp.update narrationCreationMsg model.narrationCreationApp
      in
        ({ model | narrationCreationApp = newNarrationCreationModel }, Cmd.map NarrationCreationMsg cmd)
    NarrationOverviewMsg narrationOverviewMsg ->
      let
        (newNarrationOverviewModel, cmd) = NarrationOverviewApp.update narrationOverviewMsg model.narrationOverviewApp
      in
        ({ model | narrationOverviewApp = newNarrationOverviewModel }, Cmd.map NarrationOverviewMsg cmd)
    ChapterEditMsg chapterEditMsg ->
      let
        (newNarratorModel, cmd) = ChapterEditApp.update chapterEditMsg model.chapterEditApp
      in
        ({ model | chapterEditApp = newNarratorModel }, Cmd.map ChapterEditMsg cmd)
    ChapterControlMsg chapterControlMsg ->
      let
        (newChapterControlModel, cmd) = ChapterControlApp.update chapterControlMsg model.chapterControlApp
      in
        ({ model | chapterControlApp = newChapterControlModel }, Cmd.map ChapterControlMsg cmd)
    CharacterCreationMsg characterCreationMsg ->
      let
        (newCharacterCreationModel, cmd) = CharacterCreationApp.update characterCreationMsg model.characterCreationApp
      in
        ({ model | characterCreationApp = newCharacterCreationModel }, Cmd.map CharacterCreationMsg cmd)
    _ ->
      (model, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch [ Sub.map ReaderMsg (ReaderApp.subscriptions model.readerApp)
            , Sub.map CharacterMsg (CharacterApp.subscriptions model.characterApp)
            , Sub.map NarratorDashboardMsg (NarratorDashboardApp.subscriptions model.narratorDashboardApp)
            , Sub.map NarrationCreationMsg (NarrationCreationApp.subscriptions model.narrationCreationApp)
            , Sub.map NarrationOverviewMsg (NarrationOverviewApp.subscriptions model.narrationOverviewApp)
            , Sub.map ChapterEditMsg (ChapterEditApp.subscriptions model.chapterEditApp)
            , Sub.map ChapterControlMsg (ChapterControlApp.subscriptions model.chapterControlApp)
            , Sub.map CharacterCreationMsg (CharacterCreationApp.subscriptions model.characterCreationApp)
            ]

notFoundView : Html Msg
notFoundView =
  div []
    [ div [] [ text "404 Not Found" ]
    ]

mainApplicationView : Model -> Html Msg
mainApplicationView model =
  case model.route of
    Routing.ChapterReaderPage chapterId characterToken ->
      App.map ReaderMsg (ReaderApp.view model.readerApp)
    Routing.CharacterPage characterToken ->
      App.map CharacterMsg (CharacterApp.view model.characterApp)
    Routing.NarratorIndex ->
      App.map NarratorDashboardMsg (NarratorDashboardApp.view model.narratorDashboardApp)
    Routing.NarrationCreationPage ->
      App.map NarrationCreationMsg (NarrationCreationApp.view model.narrationCreationApp)
    Routing.NarrationPage narrationId ->
      App.map NarrationOverviewMsg (NarrationOverviewApp.view model.narrationOverviewApp)
    Routing.CreateChapterPage narrationId ->
      App.map ChapterEditMsg (ChapterEditApp.view model.chapterEditApp)
    Routing.ChapterEditNarratorPage chapterId ->
      App.map ChapterEditMsg (ChapterEditApp.view model.chapterEditApp)
    Routing.ChapterControlPage chapterId ->
      App.map ChapterControlMsg (ChapterControlApp.view model.chapterControlApp)
    Routing.CharacterCreationPage chapterId ->
      App.map CharacterCreationMsg (CharacterCreationApp.view model.characterCreationApp)
    Routing.NotFoundRoute ->
      notFoundView

main : Program Never
main =
  Navigation.program Routing.parser
    { init = initialState
    , update = combinedUpdate
    , urlUpdate = combinedUrlUpdate
    , subscriptions = subscriptions
    , view = mainApplicationView
    }
