module Tests exposing (all)

import DecisionTree exposing (DecisionTree(..))
import Expect
import Maybe exposing (Maybe(..))
import Route exposing (Route(..))
import Test exposing (..)
import Trees exposing (h2g2, python)



-- Check out https://package.elm-lang.org/packages/elm-explorations/test/latest to learn more about testing in Elm!


all : Test
all =
    Test.describe "Walking A Tree"
        [ test "Root" <|
            \_ ->
                Expect.equal
                    (Just h2g2)
                    (DecisionTree.next h2g2 [])
        , test "Valid Path" <|
            \_ ->
                Expect.equal
                    (Just (Leaf { label = "Correct!" }))
                    (DecisionTree.next h2g2 [ "42" ])
        , test "Invalid Path" <|
            \_ ->
                Expect.equal
                    Nothing
                    (DecisionTree.next h2g2 [ "fame" ])
        , test "Multiple Steps" <|
            \_ ->
                Expect.equal
                    (Just (Leaf { label = "Right. Off you go." }))
                    (DecisionTree.next python [ "lancelot", "grail", "blue" ])
        , test "Describe" <|
            \_ ->
                Expect.equal
                    (Just
                        [ { path = []
                          , question = "What is your name?"
                          , answer = "Arthur, King of the Britons"
                          }
                        , { path = [ "arthur" ]
                          , question = "What is your quest?"
                          , answer = "To seek The Holy Grail."
                          }
                        , { path = [ "arthur", "grail" ]
                          , question = "What is the airspeed velocity of an unladen swallow?"
                          , answer = "What do you mean? What do you mean, an African or European swallow?"
                          }
                        ]
                    )
                    (DecisionTree.describe python [ "arthur", "grail", "clarify" ])
        , test "URL Parsing" <|
            \_ ->
                Expect.equal
                    (Just (Tree [ "lancelot", "grail", "blue" ]))
                    (Route.fromString "https://example.com/t/lancelot/grail/blue")
        , test "Routing" <|
            \_ ->
                Expect.equal
                    (Just (Leaf { label = "Hee hee heh." }))
                    (case Route.fromString "https://example.com/t/robin/grail/yellow" of
                        Just (Tree path) ->
                            DecisionTree.next python path

                        _ ->
                            Nothing
                    )
        ]
