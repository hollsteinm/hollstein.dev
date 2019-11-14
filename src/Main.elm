module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Css exposing (..)
import Html
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Page.Career as Career
import Page.Connect as Connect
import Page.Index as Index
import Page.Websites as Websites
import Routes as Routes exposing (Route, routeMatchUrl, routeParseUrl, routeView)
import Style as Style exposing (footer, header, main_)
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
init flags url key =
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
initLoadPage ( model, cmd ) =
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
        ( title, content ) =
            case model.page of
                Index indexTitle ->
                    ( indexTitle, Index.view )

                Career careerTitle ->
                    ( careerTitle, Career.view )

                Websites websiteTitle ->
                    ( websiteTitle, Websites.view )

                Connect connectTitle ->
                    ( connectTitle, Connect.view )
    in
    { title = title
    , body =
        [ Html.Styled.toUnstyled
            (Style.appBody []
                [ Style.header []
                    [ Style.appLogo
                    , div [ css [ Style.flexContainerColumns ] ]
                        [ h1 []
                            [ text "Martin Hollstein"
                            ]
                        , span []
                            [ viewIdentity "Role" "Cloud Native Developer"
                            , viewIdentity "Location" "Wisconsin - U.S.A"
                            , viewIdentity "Certifications" "AWS Solutions Architect - Professional (9EMDJ7X2JJF4175C)"
                            ]
                        ]
                    , Style.nav []
                        [ Routes.routeView title
                        ]
                    ]
                , Style.main_ []
                    [ h2 []
                        [ text title
                        ]
                    , article []
                        content
                    ]
                , Style.footer []
                    [ text "Copyright 2019, Martin Hollstein"
                    ]
                ]
            )
        ]
    }


viewIdentity : String -> String -> Html msg
viewIdentity label value =
    p []
        [ Html.Styled.small []
            [ text label
            , text ": "
            ]
        , text value
        ]
