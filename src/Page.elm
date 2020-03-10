module Page exposing (Msg, Page, getPage, update, view)

import Browser
import DecisionTree exposing (DecisionTree(..), Node, Path, describe)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)
import Page.Decision as DecisionPage
import Page.NotFound as NotFound
import Page.Question as QuestionPage
import Route exposing (Route(..))
import Trees exposing (recipes)


type Msg
    = DecisionMsg DecisionPage.Msg


type Page
    = Question Path QuestionPage.Model
    | Decision Path DecisionPage.Model
    | NotFound NotFound.Model


getPage : Maybe Route -> ( Page, Cmd Msg )
getPage route =
    case route of
        Just (Tree path) ->
            case DecisionTree.next recipes path of
                Just (Parent question) ->
                    ( Question path (QuestionPage.init question), Cmd.none )

                Just (Leaf decision) ->
                    let
                        ( model, msg ) =
                            DecisionPage.init decision
                    in
                    ( Decision path model, Cmd.map DecisionMsg msg )

                Nothing ->
                    ( NotFound NotFound.init, Cmd.none )

        _ ->
            ( NotFound NotFound.init, Cmd.none )


update : Msg -> Page -> ( Page, Cmd Msg )
update msg page =
    case ( msg, page ) of
        ( DecisionMsg subMsg, Decision path model ) ->
            DecisionPage.update subMsg model
                |> updateWith (Decision path) DecisionMsg

        ( _, _ ) ->
            ( page, Cmd.none )


view : Page -> Browser.Document msg
view page =
    let
        blocks =
            getBlocks page
    in
    { title = "Decision Tree"
    , body =
        List.map
            Html.Styled.toUnstyled
            [ div [ class "grid" ]
                [ viewHeader
                , nav [ id "sidebar" ] blocks.sidebar
                , main_ [] [ blocks.content ]
                ]
            ]
    }



-- HELPERS --


getBlocks : Page -> { content : Html msg, sidebar : List (Html msg) }
getBlocks page =
    case page of
        Question path model ->
            { content = .content <| QuestionPage.view model
            , sidebar = viewPath recipes path
            }

        Decision path model ->
            { content = .content <| DecisionPage.view model
            , sidebar = viewPath recipes path
            }

        NotFound model ->
            { content = .content <| NotFound.view model
            , sidebar = [ text "Page Not Found" ]
            }


updateWith : (subModel -> Page) -> (subMsg -> Msg) -> ( subModel, Cmd subMsg ) -> ( Page, Cmd Msg )
updateWith toPage toMsg ( subModel, subCmd ) =
    ( toPage subModel
    , Cmd.map toMsg subCmd
    )


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
