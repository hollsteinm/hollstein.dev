module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Css exposing (alignItems, auto, color, opacity, em, hidden, hover, int, listStyleType, margin2, maxWidth, none, paddingLeft, paddingRight, paddingTop, pct, px, stretch, textDecoration, textTransform, uppercase, visibility, visible, visited, width)
import Html.Styled exposing (Html, a, article, b, div, h1, li, span, text, ul)
import Html.Styled.Attributes exposing (css, href)
import Page.Career as Career exposing (title)
import Page.Connect as Connect exposing (title)
import Page.Index as Index exposing (title)
import Page.Websites as Websites exposing (title)
import Routes as Routes exposing (Route, routeMatchUrl, routeParseUrl)
import Style as Style exposing (backgroundCenter, backgroundLeft, backgroundRight, flexChild, flexContainerColumns, footer, header, main_, theme, nav)
import Url



-- MAIN


main : Program () Model Msg
main =
    Browser.application
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
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    let
        model =
            { key = key
            , url = url
            , page = Index Index.title
            , route = Routes.Index
            }
    in
    ( model, Cmd.none )
        |> initLoadPage



-- UPDATE


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

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
    case route of
        Routes.Index ->
            ( { model | page = Index Index.title }, Cmd.none )

        Routes.Career ->
            ( { model | page = Career Career.title }, Cmd.none )

        Routes.Websites ->
            ( { model | page = Websites Websites.title }, Cmd.none )

        Routes.Connect ->
            ( { model | page = Connect Connect.title }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    let
        ( title, content, navDisplay ) =
            case model.page of
                Index indexTitle ->
                    ( indexTitle, Index.view, [ visibility hidden, opacity (int 0) ] )

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
                [ backgroundCenter
                , backgroundLeft
                , backgroundRight
                , Style.header []
                    [ span [ css [ Style.flexContainerRows, maxWidth (px 1366), width (px 1366), margin2 (em 0) auto, alignItems stretch ] ]
                        [ Style.appLogo
                        , div [ css [ Style.flexContainerColumns ] ]
                            [ h1 []
                                [ text "Martin Hollstein"
                                ]
                            , span []
                                [ text "Cloud Native Architect Developer in Wisconsin"
                                ]
                            ]
                        , Style.nav [ css navDisplay ]
                            [ routeView title
                            ]
                        ]
                    ]
                , Style.main_ []
                    [ Style.article []
                        content
                    ]
                , Style.footer []
                    [ span [ css [ Style.flexContainerRows, maxWidth (px 1366), width (px 1366), margin2 (em 0) auto, alignItems stretch ] ]
                        [ text "Copyright 2019, Martin Hollstein"
                        ]
                    ]
                ]
            )
        ]
    }


routeView : String -> Html msg
routeView activeTitle =
    ul [ css [ flexContainerColumns, paddingLeft (em 0), paddingTop (em 0.25), paddingRight (em 0.25), listStyleType none ] ]
        [ viewLink (routeMatchUrl Routes.Index) Index.title activeTitle
        , viewLink (routeMatchUrl Routes.Career) Career.title activeTitle
        , viewLink (routeMatchUrl Routes.Websites) Websites.title activeTitle
        , viewLink (routeMatchUrl Routes.Connect) Connect.title activeTitle
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
                [ color theme.highlight
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
