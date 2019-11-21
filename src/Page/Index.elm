module Page.Index exposing (title, view)

import Html.Styled exposing (Html, text)


title : String
title =
    "Home"


view : List (Html msg)
view =
    [ text "This is some text about my website" ]
