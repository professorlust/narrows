module CharacterEditApp.Models exposing (..)

import Json.Decode
import Common.Models exposing (Character, Banner)


type alias ChapterSummary =
    { id : Int
    , title : String
    }


type alias NarrationSummary =
    { id : Int
    , title : String
    , chapters : List ChapterSummary
    }


type alias CharacterInfo =
    { id : Int
    , token : String
    , email : String
    , name : String
    , avatar : Maybe String
    , novelToken : String
    , description : Json.Decode.Value
    , backstory : Json.Decode.Value
    , narration : NarrationSummary
    }


type alias CharacterTokenResponse =
    { token : String
    }


type alias Model =
    { characterId : Int
    , characterInfo : Maybe CharacterInfo
    , newAvatarUrl : Maybe String
    , showResetCharacterTokenDialog : Bool
    , showTokenInfoBox : Bool
    , showNovelTokenInfoBox : Bool
    , banner : Maybe Banner
    }
