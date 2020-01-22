module Tests exposing (all)

import DecisionTree exposing (..)
import Dict exposing (Dict)
import Expect
import Maybe exposing (Maybe(..))
import Route exposing (Route(..))
import Test exposing (..)
import Url



-- Check out https://package.elm-lang.org/packages/elm-explorations/test/latest to learn more about testing in Elm!


all : Test
all =
    describe "Walking A Tree"
        [ test "Valid Step" <|
            \_ ->
                Expect.equal
                    (Just (Decision "Correct!"))
                    (walk [ "42" ] h2g2)
        , test "Invalid Step" <|
            \_ ->
                Expect.equal
                    Nothing
                    (walk [ "fame" ] h2g2)
        , test "Multiple Steps" <|
            \_ ->
                Expect.equal
                    (Just (Decision "Right. Off you go."))
                    (walk [ "lancelot", "grail", "blue" ] python)
        , test "URL Parsing" <|
            \_ ->
                Expect.equal
                    (Just (Tree [ "lancelot", "grail", "blue" ]))
                    (Route.fromString "https://example.com/t/lancelot/grail/blue")
        , test "Routing" <|
            \_ ->
                Expect.equal
                    (Just (Decision "Hee hee heh."))
                    (case Route.fromString "https://example.com/t/robin/grail/yellow" of
                        Just (Tree path) ->
                            walk path python

                        _ ->
                            Nothing
                    )
        ]


h2g2 =
    Question "What is the answer to life, the universe, and everything?"
        (Dict.fromList
            [ ( "love", Decision "As you wish." )
            , ( "money", Decision "You have chosen poorly." )
            , ( "42", Decision "Correct!" )
            ]
        )


python =
    Question "What is your name?"
        (Dict.fromList
            [ ( "arthur", quest )
            , ( "lancelot", quest )
            , ( "robin", quest )
            ]
        )


quest =
    Question "What is your quest?"
        (Dict.fromList
            [ ( "grail", color )
            ]
        )


color =
    Question "What is your favorite color?"
        (Dict.fromList
            [ ( "blue", Decision "Right. Off you go." )
            , ( "yellow", Decision "Hee hee heh." )
            ]
        )
