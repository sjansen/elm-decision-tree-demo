module Tests exposing (all)

import DecisionTree exposing (DecisionTree(..))
import Dict exposing (Dict)
import Expect
import Maybe exposing (Maybe(..))
import Route exposing (Route(..))
import Test exposing (..)



-- Check out https://package.elm-lang.org/packages/elm-explorations/test/latest to learn more about testing in Elm!


all : Test
all =
    Test.describe "Walking A Tree"
        [ test "Valid Path" <|
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
                        [ { path = "/"
                          , question = "What is your name?"
                          , answer = "Lancelot"
                          }
                        , { path = "/lancelot/"
                          , question = "What is your quest?"
                          , answer = "The Holy Grail"
                          }
                        , { path = "/lancelot/grail/"
                          , question = "What is your favorite color?"
                          , answer = "Blue"
                          }
                        ]
                    )
                    (DecisionTree.describe python [ "lancelot", "grail", "blue" ])
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


h2g2 : DecisionTree
h2g2 =
    Parent
        { label = "What is the answer to life, the universe, and everything?"
        , alternatives =
            Dict.fromList
                [ ( "love"
                  , { label = "Love"
                    , tree = Leaf { label = "As you wish." }
                    }
                  )
                , ( "money"
                  , { label = "Money"
                    , tree = Leaf { label = "You have chosen poorly." }
                    }
                  )
                , ( "42"
                  , { label = "42"
                    , tree = Leaf { label = "Correct!" }
                    }
                  )
                ]
        }


python : DecisionTree
python =
    Parent
        { label = "What is your name?"
        , alternatives =
            Dict.fromList
                [ ( "arthur"
                  , { label = "Arthur"
                    , tree = quest
                    }
                  )
                , ( "lancelot"
                  , { label = "Lancelot"
                    , tree = quest
                    }
                  )
                , ( "robin"
                  , { label = "Robin"
                    , tree = quest
                    }
                  )
                ]
        }


quest : DecisionTree
quest =
    Parent
        { label = "What is your quest?"
        , alternatives =
            Dict.fromList
                [ ( "grail"
                  , { label = "The Holy Grail"
                    , tree = color
                    }
                  )
                ]
        }


color : DecisionTree
color =
    Parent
        { label = "What is your favorite color?"
        , alternatives =
            Dict.fromList
                [ ( "blue"
                  , { label = "Blue"
                    , tree = Leaf { label = "Right. Off you go." }
                    }
                  )
                , ( "yellow"
                  , { label = "Yellow"
                    , tree = Leaf { label = "Hee hee heh." }
                    }
                  )
                ]
        }
