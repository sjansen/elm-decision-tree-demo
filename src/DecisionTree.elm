module DecisionTree exposing (DecisionTree(..), Path, describe, next)

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
    }


type alias Path =
    List AltID


type alias Question =
    { label : String
    , alternatives : Dict AltID Alternative
    }


type alias Step =
    { path : String
    , question : String
    , answer : String
    }


describe : DecisionTree -> Path -> Maybe (List Step)
describe tree path =
    describeSteps "/" tree path


next : DecisionTree -> Path -> Maybe DecisionTree
next tree path =
    case path of
        [] ->
            Nothing

        key :: [] ->
            getTree key tree

        key :: keys ->
            case getTree key tree of
                Just subtree ->
                    next subtree keys

                Nothing ->
                    Nothing



-- HELPERS --


describeSteps : String -> DecisionTree -> Path -> Maybe (List Step)
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
                    case describeSteps (prefix ++ key ++ "/") subtree keys of
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


getStep : String -> AltID -> Question -> Maybe Step
getStep path key question =
    case Dict.get key question.alternatives of
        Just alternative ->
            Just
                { question = question.label
                , answer = alternative.label
                , path = path
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
