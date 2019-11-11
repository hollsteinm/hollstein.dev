module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Html as Html exposing (..)
import Html.Attributes exposing (..)
import Page exposing (PageMsg)
import Page.Career as Career
import Page.Index as Index
import Routes as Routes exposing (..)
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
    = Index Index.Model
    | Career Career.Model


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
            , page = Index Index.view
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
            ( { model | page = Index Index.view }, Cmd.none )

        Routes.Career ->
            ( { model | page = Career Career.view }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    let
        { title, content } =
            case model.page of
                Index indexModel ->
                    indexModel

                Career careerModel ->
                    careerModel
    in
    { title = title
    , body =
        [ text "The current URL is: "
        , b [] [ text (Url.toString model.url) ]
        , ul []
            [ viewLink "/"
            , viewLink "/career"
            ]
        ]
    }


viewLink : String -> Html msg
viewLink path =
    li [] [ a [ href path ] [ text path ] ]
