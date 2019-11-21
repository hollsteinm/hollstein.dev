module Routes exposing (Route(..), routeMatchUrl, routeParseUrl, routeView)

import Css exposing (auto, color, em, hover, listStyleType, margin2, none, paddingLeft, paddingRight, paddingTop, pct, textDecoration, textTransform, uppercase, visited, width)
import Html.Styled exposing (Html, a, b, li, text, ul)
import Html.Styled.Attributes exposing (css, href)
import Page.Career as Career exposing (title)
import Page.Connect as Connect exposing (title)
import Page.Index as Index exposing (title)
import Page.Websites as Websites exposing (title)
import Style exposing (flexChild, flexContainerColumns, theme)
import Url exposing (Url)
import Url.Parser as Parser exposing (Parser, oneOf, s)


type Route
    = Index
    | Career
    | Websites
    | Connect


routeMatcher : Parser (Route -> a) a
routeMatcher =
    oneOf
        [ Parser.map Index Parser.top
        , Parser.map Career (s "career")
        , Parser.map Websites (s "websites")
        , Parser.map Connect (s "connect")
        ]


routeParseUrl : Url -> Route
routeParseUrl url =
    case Parser.parse routeMatcher url of
        Just route ->
            route

        Nothing ->
            Index


routeMatchUrl : Route -> String
routeMatchUrl route =
    case route of
        Index ->
            "/"

        Career ->
            "/career"

        Websites ->
            "/websites"

        Connect ->
            "/connect"


routeView : String -> Html msg
routeView activeTitle =
    ul [ css [ flexContainerColumns, paddingLeft (em 0), paddingTop (em 0.25), paddingRight (em 0.25), listStyleType none ] ]
        [ viewLink (routeMatchUrl Index) Index.title activeTitle
        , viewLink (routeMatchUrl Career) Career.title activeTitle
        , viewLink (routeMatchUrl Websites) Websites.title activeTitle
        , viewLink (routeMatchUrl Connect) Connect.title activeTitle
        ]


lia : String -> List (Html msg) -> Html msg
lia path children =
    a
        [ href path
        , css
            [ textDecoration none
            , textTransform uppercase
            , width (pct 100)
            , margin2 auto (em 0.25)
            , color theme.primary
            , visited
                [ color theme.primary
                ]
            , hover
                [ color theme.secondary
                ]
            ]
        ]
        children


viewLink : String -> String -> String -> Html msg
viewLink path displayName active =
    let
        innerStyle =
            if active == displayName then
                lia path
                    [ b []
                        [ text displayName
                        ]
                    ]

            else
                lia path
                    [ text displayName
                    ]
    in
    li
        [ css
            [ flexChild
            , paddingTop (em 0.5)
            , margin2 auto (em 0.25)
            , width (pct 100)
            ]
        ]
        [ innerStyle
        ]
