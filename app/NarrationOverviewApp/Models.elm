module NarrationOverviewApp.Models exposing (..)

import Dict exposing (Dict)
import ISO8601
import Common.Models exposing (Narration, Banner, NarrationOverview)


type alias NarrationNovel =
    { id : Int
    , characterId : Int
    , token : String
    , created : String
    }


type alias SendPendingIntroEmailsResponse =
    { characters : Dict String SendIntroDate
    }

type alias SendIntroDate =
    { sendIntroDate : ISO8601.Time
    }


type alias Model =
    { narrationOverview : Maybe NarrationOverview
    , sendingPendingIntroEmails : Bool
    , banner : Maybe Banner
    }
