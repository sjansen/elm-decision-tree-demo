module Trees exposing (h2g2, python)

import DecisionTree exposing (DecisionTree(..))
import Dict exposing (Dict)


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
                  , { label = "Arthur, King of the Britons"
                    , tree = quest2
                    }
                  )
                , ( "lancelot"
                  , { label = "Lancelot"
                    , tree = quest1
                    }
                  )
                , ( "robin"
                  , { label = "Robin"
                    , tree = quest1
                    }
                  )
                ]
        }


quest1 : DecisionTree
quest1 =
    Parent
        { label = "What is your quest?"
        , alternatives =
            Dict.fromList
                [ ( "grail"
                  , { label = "To seek The Holy Grail."
                    , tree = color
                    }
                  )
                ]
        }


quest2 : DecisionTree
quest2 =
    Parent
        { label = "What is your quest?"
        , alternatives =
            Dict.fromList
                [ ( "grail"
                  , { label = "To seek The Holy Grail."
                    , tree = swallow
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


swallow : DecisionTree
swallow =
    Parent
        { label = "What is the airspeed velocity of an unladen swallow?"
        , alternatives =
            Dict.fromList
                [ ( "clarify"
                  , { label = "What do you mean? What do you mean, an African or European swallow?"
                    , tree = Leaf { label = "I... I don't know that." }
                    }
                  )
                ]
        }
