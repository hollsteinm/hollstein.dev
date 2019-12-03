module Page.Index exposing (title, view)

import Css exposing (alignItems, auto, color, em, flexEnd, hover, important, justifyContent, margin2, margin4, maxWidth, none, paddingTop, pct, px, textDecoration, textTransform, uppercase, visited, width)
import Html.Styled exposing (Html, a, div, text)
import Html.Styled.Attributes exposing (css, href)
import Page.Career as Career exposing (title)
import Page.Connect as Connect exposing (title)
import Page.Websites as Websites exposing (title)
import Routes as Routes exposing (routeMatchUrl)
import Style exposing (flexChild, flexContainerColumns, flexContainerRows, h1, h2, p, theme)


title : String
title =
    "Home"


view : List (Html msg)
view =
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
            [ text "This website is all about the technological and professional portfolio for Martin Hollstein. I appreciate your time for visiting and getting to know me at a professional level."
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
            [ bigLink (routeMatchUrl Routes.Career) Career.title
            , bigLink (routeMatchUrl Routes.Websites) Websites.title
            , bigLink (routeMatchUrl Routes.Connect) Connect.title
            ]
        ]
    ]


bigLink : String -> String -> Html msg
bigLink path displayName =
    h2 []
        [ a
            [ href path
            , css
                [ textDecoration none
                , textTransform uppercase
                , margin2 auto (em 0.25)
                , color theme.primary
                , visited
                    [ color theme.primary
                    ]
                , hover
                    [ color theme.highlight
                    ]
                ]
            ]
            [ text displayName
            ]
        ]
