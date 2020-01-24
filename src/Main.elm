module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import DecisionTree exposing (DecisionTree(..), eachAlternative)
import Html exposing (Html, a, div, h1, img, li, p, text, ul)
import Html.Attributes exposing (href, src)
import Route exposing (Route(..))
import Trees exposing (python)
import Url


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        , onUrlChange = UrlChanged
        , onUrlRequest = LinkClicked
        }



---- MODEL ----


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model key url, Cmd.none )



---- UPDATE ----


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
            ( { model | url = url }
            , Cmd.none
            )



---- VIEW ----


view : Model -> Browser.Document Msg
view model =
    { title = "Decision Tree"
    , body =
        [ div []
            [ a [ href "/" ] [ img [ src "/logo.svg" ] [] ]
            , h1 [] [ text "Your Elm App is working!" ]
            , case Route.fromUrl model.url of
                Just (Tree path) ->
                    case DecisionTree.next python path of
                        Just (Parent question) ->
                            p []
                                [ text question.label
                                , ul []
                                    (eachAlternative
                                        (\k v l ->
                                            li [] [ a [ href (k ++ "/") ] [ text v.label ] ] :: l
                                        )
                                        []
                                        question.alternatives
                                    )
                                ]

                        Just (Leaf decision) ->
                            p [] [ text decision.label ]

                        Nothing ->
                            p [] [ text "Not Found" ]

                _ ->
                    p [] [ a [ href "/t/" ] [ text "python" ] ]
            ]
        ]
    }
