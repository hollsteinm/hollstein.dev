module Main exposing (main)

import Browser exposing (application)
import Browser.Navigation as Nav
import Json.Encode as Encode
import Css exposing (display, alignItems, auto, color, em, hidden, hover, int, listStyleType, margin2, maxWidth, minWidth, none, opacity, paddingLeft, paddingRight, paddingTop, pct, px, stretch, textDecoration, textTransform, uppercase, visibility, visible, visited, width)
import Css.Media as Media exposing (screen, only, withMedia)
import Html.Styled exposing (Html, a, article, div, h2, li, span, text, ul)
import Html.Styled.Attributes exposing (css, href, property)
import Page.Career as Career exposing (title)
import Page.Connect as Connect exposing (title)
import Page.Index as Index exposing (title)
import Page.Websites as Websites exposing (title)
import Process
import Routes as Routes exposing (Route, routeMatchUrl, routeParseUrl)
import Style as Style exposing (flexChild, flexContainerColumns, footer, h3, header, main_, nav, onClickPreventDefault, theme)
import Task
import Url



-- MAIN


main : Program () Model Msg
main =
    application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



-- MODEL


type Page
    = Index String
    | Career String
    | Websites String
    | Connect String


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , page : Page
    , route : Route
    , mainOpacity : Int
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    let
        model =
            { key = key
            , url = url
            , page = Index Index.title
            , route = Routes.Index
            , mainOpacity = 0
            }
    in
    ( model, Cmd.none )
        |> initLoadPage


delay : Float -> msg -> Cmd msg
delay time msg =
    Process.sleep time
        |> Task.andThen (always <| Task.succeed msg)
        |> Task.perform identity



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | NavClicked String
    | UrlChanged Url.Url
    | MainOpacitySet Int
    | DelayedLocalLoad Nav.Key String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        DelayedLocalLoad key path ->
            ( model, Nav.pushUrl key path )

        MainOpacitySet value ->
            ( { model | mainOpacity = value }, Cmd.none )

        NavClicked path ->
            if path /= model.url.path then
                ( { model | mainOpacity = 0 }, delay 1000 <| DelayedLocalLoad model.key path )
            else
                ( model, Cmd.none )

        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    if url /= model.url then
                        ( { model | mainOpacity = 0 }, delay 1000 <| DelayedLocalLoad model.key (Url.toString url) )
                    else
                        ( model, Cmd.none )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            loadPage (Routes.routeParseUrl url)
                { model | url = url }


initLoadPage : ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
initLoadPage ( model, _ ) =
    loadPage (Routes.routeParseUrl model.url) model


loadPage : Route -> Model -> ( Model, Cmd Msg )
loadPage route model =
    let
        cmd =
            delay 333 <| MainOpacitySet 1
    in
    case route of
        Routes.Index ->
            ( { model | page = Index Index.title }, cmd )

        Routes.Career ->
            ( { model | page = Career Career.title }, cmd )

        Routes.Websites ->
            ( { model | page = Websites Websites.title }, cmd )

        Routes.Connect ->
            ( { model | page = Connect Connect.title }, cmd )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    let
        mainVisibility =
            if model.mainOpacity == 0 then
                Css.important (visibility hidden)

            else
                Css.important (visibility visible)

        mainOpacity =
            Css.important (opacity (int model.mainOpacity))

        ( title, content, navDisplay ) =
            case model.page of
                Index indexTitle ->
                    ( indexTitle
                    , Index.view
                        [ bigLink (routeMatchUrl Routes.Career) Career.title
                        , bigLink (routeMatchUrl Routes.Websites) Websites.title
                        , bigLink (routeMatchUrl Routes.Connect) Connect.title
                        ]
                    , [ visibility hidden, opacity (int 0) ]
                    )

                Career careerTitle ->
                    ( careerTitle, Career.view, [ visibility visible, opacity (int 1) ] )

                Websites websiteTitle ->
                    ( websiteTitle, Websites.view, [ visibility visible, opacity (int 1) ] )

                Connect connectTitle ->
                    ( connectTitle, Connect.view, [ visibility visible, opacity (int 1) ] )
    in
    { title = title
    , body =
        [ Html.Styled.toUnstyled
            (Style.appBody []
                [ div [property "className" (Encode.string "bg bg-center")] []
                , div [property "className" (Encode.string "bg bg-right")] []
                , div [property "className" (Encode.string "bg bg-left")] []
                , Style.header []
                    [ span [ css [ Style.flexContainerRows, maxWidth (px 1366), width (px 1366), margin2 (em 0) auto, alignItems stretch ] ]
                        [ Style.appLogo
                        , div [ css [ Style.flexContainerColumns ] ]
                            [ h2 []
                                [ text "Martin Hollstein"
                                ]
                            , span [ css [ withMedia [only screen [Media.maxWidth (px 719)]] [ display none ] ]]
                                [ text "Cloud Application Developer & Architect in Wisconsin"
                                ]
                            ]
                        , Style.nav [ css navDisplay ]
                            [ routeView title
                            ]
                        ]
                    ]
                , Style.main_ [ css [ mainVisibility, mainOpacity ] ]
                    [ Style.article []
                        content
                    ]
                , Style.footer []
                    [ span [ css [ Style.flexContainerRows, maxWidth (px 1366), width (px 1366), margin2 (em 0) auto, alignItems stretch ] ]
                        [ text "Copyright 2020, Martin Hollstein"
                        ]
                    ]
                ]
            )
        ]
    }


routeView : String -> Html Msg
routeView activeTitle =
    ul [ css [ flexContainerColumns, paddingLeft (em 0), paddingTop (em 0.25), paddingRight (em 0.25), listStyleType none ] ]
        [ viewLink (routeMatchUrl Routes.Index) Index.title activeTitle
        , viewLink (routeMatchUrl Routes.Career) Career.title activeTitle
        , viewLink (routeMatchUrl Routes.Websites) Websites.title activeTitle
        , viewLink (routeMatchUrl Routes.Connect) Connect.title activeTitle
        ]


bigLink : String -> String -> Html Msg
bigLink path displayName =
    h3 []
        [ a
            [ href path
            , onClickPreventDefault (NavClicked path)
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


viewLink : String -> String -> String -> Html Msg
viewLink path displayName active =
    let
        selectedVisibility =
            if active == displayName then
                visibility visible

            else
                visibility hidden
    in
    li
        [ css
            [ flexChild
            , paddingTop (em 0.5)
            , margin2 auto (em 0.25)
            , width (pct 100)
            ]
        ]
        [ span [ css [ minWidth (em 1), selectedVisibility, margin2 auto (em 0) ] ]
            [ text ">"
            ]
        , a
            [ href path
            , onClickPreventDefault (NavClicked path)
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
                    [ color theme.highlight
                    ]
                ]
            ]
            [ text displayName
            ]
        ]
