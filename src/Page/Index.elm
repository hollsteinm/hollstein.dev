module Page.Index exposing (view, title)

import Html
import Html.Styled exposing (Html, text)

title : String
title = "Home"

view : List(Html msg)
view =
    [text "This is some text about my website"]
