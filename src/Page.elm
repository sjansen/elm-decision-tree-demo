module Page exposing (view)

import Browser
import DecisionTree exposing (DecisionTree(..))
import Html.Styled exposing (Html, a, div, h1, header, img, main_, nav, span, text)
import Html.Styled.Attributes exposing (class, href, id, src)
import Page.Decision as Decision
import Page.NotFound as NotFound
import Page.Question as Question
import Route exposing (Route(..))
import Trees exposing (menu)


view : Maybe Route -> Browser.Document msg
view route =
    { title = "Decision Tree"
    , body =
        List.map
            Html.Styled.toUnstyled
            [ div [ class "grid" ]
                [ viewHeader
                , viewNav
                , viewMain route
                ]
            ]
    }


viewHeader : Html msg
viewHeader =
    header []
        [ span [ id "logo" ]
            [ a [ href "/t/" ]
                [ img [ src "/logo.svg" ] [] ]
            ]
        , h1 [] [ text "DecisionTree" ]
        ]


viewNav : Html msg
viewNav =
    nav [ id "main-nav" ] [ text "TODO" ]


viewMain : Maybe Route -> Html msg
viewMain route =
    main_ []
        [ case route of
            Just (Tree path) ->
                case DecisionTree.next menu path of
                    Just (Parent question) ->
                        Question.view question

                    Just (Leaf decision) ->
                        Decision.view decision

                    Nothing ->
                        NotFound.view

            _ ->
                NotFound.view
        ]
