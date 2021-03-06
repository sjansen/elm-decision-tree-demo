module Page.Decision exposing (Model, Msg, init, update, view)

import Css exposing (..)
import DecisionTree exposing (Decision)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Http exposing (Error(..))
import List
import Loading
import Markdown.Parser as Markdown
import Task


type alias Model =
    { decision : Decision
    , status : Status
    }


type Status
    = Failed Error
    | Loaded String
    | Loading
    | LoadingSlowly


type Msg
    = GotDetails (Result Http.Error String)
    | SlowLoadDetected


init : Decision -> ( Model, Cmd Msg )
init decision =
    ( { decision = decision
      , status = Loading
      }
    , Cmd.batch
        [ getDetails decision
        , Task.perform (\_ -> SlowLoadDetected) Loading.slowThreshold
        ]
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotDetails result ->
            case result of
                Ok markdown ->
                    ( { model | status = Loaded markdown }, Cmd.none )

                Err err ->
                    ( { model | status = Failed err }, Cmd.none )

        SlowLoadDetected ->
            case model.status of
                Loading ->
                    ( { model | status = LoadingSlowly }, Cmd.none )

                _ ->
                    ( model, Cmd.none )


view : Model -> { title : String, content : Html msg }
view model =
    { title = ""
    , content =
        div [ class "decision" ]
            [ h1 [] [ text model.decision.label ]
            , case model.status of
                Failed err ->
                    p [] [ text (loadingFailed err) ]

                Loading ->
                    p [] []

                LoadingSlowly ->
                    p [] [ text "Loading..." ]

                Loaded markdown ->
                    viewDetail markdown
            ]
    }


deadEndsToString deadEnds =
    deadEnds
        |> List.map Markdown.deadEndToString
        |> String.join "\n"


getDetails : Decision -> Cmd Msg
getDetails decision =
    case decision.detail of
        Just subpath ->
            Http.get
                { url = "/trees/recipes/v1/" ++ subpath
                , expect = Http.expectString GotDetails
                }

        Nothing ->
            Cmd.none


loadingFailed : Http.Error -> String
loadingFailed err =
    case err of
        BadUrl msg ->
            "Loading Failed: " ++ msg

        Timeout ->
            "Loading Failed: request timed out"

        NetworkError ->
            "Loading Failed: unable to connect"

        BadStatus status ->
            "Loading Failed: HTTP " ++ String.fromInt status

        BadBody msg ->
            "Loading Failed: " ++ msg


viewDetail : String -> Html msg
viewDetail markdown =
    case
        markdown
            |> Markdown.parse
            |> Result.mapError deadEndsToString
            |> Result.andThen
                (\ast ->
                    Markdown.render
                        Markdown.defaultHtmlRenderer
                        ast
                )
    of
        Ok rendered ->
            div
                [ class "detail"
                , css
                    [ border3 (px 1) solid (rgb 224 224 224)
                    ]
                ]
                [ div
                    [ css
                        [ backgroundColor (rgb 224 224 224)
                        , padding (px 2)
                        ]
                    ]
                    [ text "Details" ]
                , div
                    [ css [ padding2 (px 0) (px 5) ] ]
                    (List.map Html.Styled.fromUnstyled rendered)
                ]

        Err errors ->
            text errors
