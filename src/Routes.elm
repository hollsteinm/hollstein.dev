module Routes exposing (Route(..), routeParseUrl, routeMatchUrl)

import Url exposing (Url)
import Url.Parser as Parser exposing (Parser, oneOf, s, string)


type Route
    = Index
    | Career


routeMatcher : Parser (Route -> a) a
routeMatcher =
    oneOf
        [ Parser.map Index Parser.top
        , Parser.map Career (s "career")
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
