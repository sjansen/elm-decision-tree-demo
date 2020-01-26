module Page.Decision exposing (view)

import Css exposing (..)
import DecisionTree exposing (Decision)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import List
import Markdown.Parser as Markdown


view : Decision -> { title : String, content : Html msg }
view decision =
    { title = ""
    , content =
        div [ class "decision" ]
            [ h1 [] [ text decision.label ]
            , case decision.detail of
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
