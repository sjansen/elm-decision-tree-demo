module DecisionTree exposing (Answers, DecisionTree(..), Path, walk)

import Dict exposing (Dict)
import Maybe exposing (Maybe(..))


type DecisionTree
    = Question String Answers
    | Decision String


type alias Answers =
    Dict String DecisionTree


type alias Path =
    List String


subtree : String -> DecisionTree -> Maybe DecisionTree
subtree key tree =
    case tree of
        Question _ options ->
            Dict.get key options

        _ ->
            Nothing


walk : Path -> DecisionTree -> Maybe DecisionTree
walk path tree =
    case path of
        [] ->
            Nothing

        key :: [] ->
            subtree key tree

        key :: keys ->
            let
                x =
                    subtree key tree
            in
            case x of
                Just subtree_ ->
                    walk keys subtree_

                Nothing ->
                    Nothing
