module Page.Decision exposing (Model, init, update, view)

import Css exposing (..)
import DecisionTree exposing (Decision)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Http
import List
import Markdown.Parser as Markdown


type alias Model =
    { decision : Decision
    , status : Status
    }


type Status
    = Failed
    | Loading
    | Loaded String
    | Ready


type Msg
    = GotDetails (Result Http.Error String)


init : Decision -> Model
init decision =
    { decision = decision
    , status = Ready
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GotDetails result ->
            case result of
                Ok markdown ->
                    ( { model | status = Loaded markdown }, Cmd.none )

                Err _ ->
                    ( { model | status = Failed }, Cmd.none )


view : Model -> { title : String, content : Html msg }
view model =
    { title = ""
    , content =
        div [ class "decision" ]
            [ h1 [] [ text model.decision.label ]
            , case model.decision.detail of
                Nothing ->
                    p [] [ text "TODO" ]

                Just detail ->
                    case
                        detail
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
            ]
    }


deadEndsToString deadEnds =
    deadEnds
        |> List.map Markdown.deadEndToString
        |> String.join "\n"
