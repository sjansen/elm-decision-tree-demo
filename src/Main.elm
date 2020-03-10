module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Page exposing (Page(..), getPage)
import Route exposing (Route(..))
import Url


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



----


type alias Flags =
    { public_url : String
    }


type alias Model =
    { key : Nav.Key
    , page : Page
    , root : String
    , url : Url.Url
    }


init : Flags -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        maybeRoute =
            Route.fromUrl url

        { public_url } =
            flags

        ( page, msg ) =
            getPage maybeRoute
    in
    ( { key = key
      , page = page
      , root = public_url
      , url = url
      }
    , Cmd.map PageMsg msg
    )



---- UPDATE ----


type Msg
    = LinkClicked Browser.UrlRequest
    | PageMsg Page.Msg
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

        PageMsg subMsg ->
            let
                ( page, pageMsg ) =
                    Page.update subMsg model.page
            in
            ( { model | page = page }
            , Cmd.map PageMsg pageMsg
            )

        UrlChanged url ->
            let
                maybeRoute =
                    Route.fromUrl url

                ( page, pageMsg ) =
                    getPage maybeRoute
            in
            ( { model | page = page, url = url }
            , Cmd.map PageMsg pageMsg
            )



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    Page.view model.page
