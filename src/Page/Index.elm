module Page.Index exposing (Model, view)

import Html exposing (Html)
import Page exposing (PageMsg)


type alias Model =
    { title : String
    , content : Html PageMsg
    }


view : { title : String, content : Html PageMsg }
view =
    { title = "Martin Hollstein"
    , content = Html.text ""
    }
