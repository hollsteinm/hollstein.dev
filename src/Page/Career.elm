module Page.Career exposing (view, title)

import Html
import Html.Styled exposing (Html, text)

title : String
title = "Career"

view : List(Html msg)
view =
  [text "Here are some blurbs about my career"]

