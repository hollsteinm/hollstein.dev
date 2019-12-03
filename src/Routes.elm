module Routes exposing (Route(..), routeMatchUrl, routeParseUrl)

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
