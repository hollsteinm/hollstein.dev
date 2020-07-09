module Page.Index exposing (title, view)

import Css exposing (alignItems, auto, color, em, flexEnd, important, justifyContent, margin2, margin4, maxWidth, paddingTop, pct, px, width)
import Html.Styled exposing (Html, div, text)
import Html.Styled.Attributes exposing (css)
import Style exposing (flexChild, flexContainerColumns, flexContainerRows, h1, p, theme)


title : String
title =
    "Home"


view : List (Html msg) -> List (Html msg)
view links =
    [ h1 []
        [ text "Welcome"
        ]
    , div
        [ css [ flexContainerRows ] ]
        [ p
            [ css
                [ color theme.background
                , important (margin4 (em 0) auto (em 0) (em 0))
                , important (maxWidth (px 315))
                , flexChild
                ]
            ]
            [ text "This website is all about the technological and professional portfolio for Martin Hollstein. I appreciate your time for visiting."
            ]
        , div
            [ css
                [ flexChild
                , flexContainerColumns
                , justifyContent flexEnd
                , alignItems flexEnd
                , paddingTop (em 0.5)
                , margin2 auto (em 0.25)
                , width (pct 50)
                ]
            ]
            links
        ]
    ]
