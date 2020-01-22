module Tests exposing (..)

import DecisionTree exposing (..)
import Dict exposing (Dict)
import Expect
import Maybe exposing (Maybe(..))
import Route exposing (Route(..), fromUrl)
import Test exposing (..)
import Url



-- Check out https://package.elm-lang.org/packages/elm-explorations/test/latest to learn more about testing in Elm!


all : Test
all =
    describe "Walking A Tree"
        [ test "Valid Step" <|
            \_ ->
                Expect.equal
                    (Just (Answer "Correct!"))
                    (walk [ "42" ] h2g2)
        , test "Invalid Step" <|
            \_ ->
                Expect.equal
                    Nothing
                    (walk [ "fame" ] h2g2)
        , test "Multiple Steps" <|
            \_ ->
                Expect.equal
                    (Just (Answer "Right. Off you go."))
                    (walk [ "lancelot", "grail", "blue" ] python)
        , test "URL Parsing" <|
            \_ ->
                Expect.equal
                    (Just (Answers [ "lancelot", "grail", "blue" ]))
                    (case Url.fromString "https://example.com/t/lancelot/grail/blue" of
                        Just url ->
                            Route.fromUrl url

                        Nothing ->
                            Just Root
                    )
        ]


h2g2 =
    Question "What is the answer to life, the universe, and everything?"
        (Dict.fromList
            [ ( "love", Answer "As you wish." )
            , ( "money", Answer "You have chosen poorly." )
            , ( "42", Answer "Correct!" )
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
            [ ( "blue", Answer "Right. Off you go." )
            , ( "yellow", Answer "Hee hee heh." )
            ]
        )
