module Page exposing (view)

import Browser
import DecisionTree exposing (DecisionTree(..), Node, Path, describe)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Page.Decision as Decision
import Page.NotFound as NotFound
import Page.Question as Question
import Route exposing (Route(..))
import Trees exposing (recipes)


view : Maybe Route -> Browser.Document msg
view route =
    let
        page =
            getPage route
    in
    { title = "Decision Tree"
    , body =
        List.map
            Html.Styled.toUnstyled
            [ div [ class "grid" ]
                [ viewHeader
                , nav [ id "sidebar" ] page.sidebar
                , main_ [] [ page.content ]
                ]
            ]
    }



-- HELPERS --


getPage : Maybe Route -> { content : Html msg, sidebar : List (Html msg) }
getPage route =
    case route of
        Just (Tree path) ->
            case DecisionTree.next recipes path of
                Just (Parent question) ->
                    { content = .content <| Question.view question
                    , sidebar = viewPath recipes path
                    }

                Just (Leaf decision) ->
                    { content = .content <| Decision.view decision
                    , sidebar = viewPath recipes path
                    }

                Nothing ->
                    { content = .content <| NotFound.view
                    , sidebar = [ text "Page Not Found" ]
                    }

        _ ->
            { content = .content <| NotFound.view
            , sidebar = [ text "Page Not Found" ]
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


viewNode : Node -> List (Html msg)
viewNode node =
    [ dt []
        [ a
            [ href
                (case node.path of
                    [] ->
                        "/t/"

                    _ ->
                        "/t/" ++ String.join "/" node.path ++ "/"
                )
            ]
            [ text node.question ]
        ]
    , dd [] [ text node.answer ]
    ]


viewPath : DecisionTree -> Path -> List (Html msg)
viewPath tree path =
    let
        desc =
            describe tree path
    in
    case desc of
        Just nodes ->
            [ dl []
                (List.foldr
                    (\n html -> List.append (viewNode n) html)
                    []
                    nodes
                )
            ]

        Nothing ->
            []
