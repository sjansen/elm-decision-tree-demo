module DecisionTree exposing (Decision, DecisionTree(..), Node, Path, Question, describe, eachAlternative, next)

import Array exposing (Array)
import Dict exposing (Dict)
import Maybe exposing (Maybe(..))


type DecisionTree
    = Parent Question
    | Leaf Decision


type alias Alternative =
    { label : String
    , tree : DecisionTree
    }


type alias AltID =
    String


type alias Decision =
    { label : String
    , detail : Maybe String
    }


type alias Path =
    List AltID


type alias Question =
    { label : String
    , alternatives : Dict AltID Alternative
    }


type alias Node =
    { path : Path
    , question : String
    , answer : String
    }


describe : DecisionTree -> Path -> Maybe (List Node)
describe tree path =
    describeSteps Array.empty tree path


eachAlternative : (AltID -> Alternative -> b -> b) -> b -> Dict AltID Alternative -> b
eachAlternative fn x alternatives =
    Dict.foldr fn x alternatives


next : DecisionTree -> Path -> Maybe DecisionTree
next tree path =
    case path of
        [] ->
            Just tree

        key :: [] ->
            getTree key tree

        key :: keys ->
            case getTree key tree of
                Just subtree ->
                    next subtree keys

                Nothing ->
                    Nothing



-- HELPERS --


describeSteps : Array String -> DecisionTree -> Path -> Maybe (List Node)
describeSteps prefix tree path =
    case ( path, tree ) of
        ( [], _ ) ->
            Nothing

        ( _, Leaf _ ) ->
            Nothing

        ( key :: [], Parent question ) ->
            case getStep prefix key question of
                Just step ->
                    Just [ step ]

                Nothing ->
                    Nothing

        ( key :: keys, Parent question ) ->
            let
                maybeStep =
                    getStep prefix key question

                maybeTree =
                    getAlternative key question
            in
            case ( maybeStep, maybeTree ) of
                ( Just step, Just subtree ) ->
                    case describeSteps (Array.push key prefix) subtree keys of
                        Just steps ->
                            Just (step :: steps)

                        Nothing ->
                            Nothing

                ( _, _ ) ->
                    Nothing


getAlternative : AltID -> Question -> Maybe DecisionTree
getAlternative key question =
    case Dict.get key question.alternatives of
        Just alternative ->
            Just alternative.tree

        Nothing ->
            Nothing


getStep : Array String -> AltID -> Question -> Maybe Node
getStep path key question =
    case Dict.get key question.alternatives of
        Just alternative ->
            Just
                { path = Array.toList path
                , question = question.label
                , answer = alternative.label
                }

        Nothing ->
            Nothing


getTree : AltID -> DecisionTree -> Maybe DecisionTree
getTree key tree =
    case tree of
        Parent question ->
            case Dict.get key question.alternatives of
                Just alternative ->
                    Just alternative.tree

                Nothing ->
                    Nothing

        _ ->
            Nothing
