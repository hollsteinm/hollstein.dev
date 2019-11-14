module Routes exposing (Route(..), routeMatchUrl, routeParseUrl, routeView)

import Css exposing (..)
import Html
import Html.Styled exposing (Html, a, li, text, ul, b)
import Html.Styled.Attributes exposing (href)
import Url exposing (Url)
import Url.Parser as Parser exposing (Parser, oneOf, s, string)
import Page.Career as Career exposing (title)
import Page.Index as Index exposing (title)
import Page.Websites as Websites exposing (title)
import Page.Connect as Connect exposing (title)

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
    ul []
        [ viewLink (routeMatchUrl Index) Index.title activeTitle
        , viewLink (routeMatchUrl Career) Career.title activeTitle
        , viewLink (routeMatchUrl Websites) Websites.title activeTitle
        , viewLink (routeMatchUrl Connect) Connect.title activeTitle
        ]


viewLink : String -> String -> String -> Html msg
viewLink path displayName active =
    let
        innerStyle =
          if active == displayName then
            a [ href path ]
              [ b []
                [ text displayName
                ]
              ]

          else
            a [ href path ]
              [ text displayName
              ]
    in
      li []
          [innerStyle
          ]
