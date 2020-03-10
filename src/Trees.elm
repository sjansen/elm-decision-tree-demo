module Trees exposing (recipes)

import DecisionTree exposing (DecisionTree(..))
import Dict


recipes : DecisionTree
recipes =
    Parent
        { label = "Which meal are you planning?"
        , alternatives =
            Dict.fromList
                [ ( "breakfast"
                  , { label = "Breakfast"
                    , tree = breakfast
                    }
                  )
                , ( "lunch"
                  , { label = "Lunch"
                    , tree = lunch
                    }
                  )
                , ( "supper"
                  , { label = "Supper"
                    , tree = supper
                    }
                  )
                ]
        }


breakfast : DecisionTree
breakfast =
    Parent
        { label = "What are you in the mood for?"
        , alternatives =
            Dict.fromList
                [ ( "bread"
                  , { label = "Bread"
                    , tree = muffins
                    }
                  )
                , ( "eggs"
                  , { label = "Eggs"
                    , tree =
                        Parent
                            { label = "How hungry are you?"
                            , alternatives =
                                Dict.fromList
                                    [ ( "normal"
                                      , { label = "Average"
                                        , tree = omelet
                                        }
                                      )
                                    , ( "very"
                                      , { label = "Very hungry"
                                        , tree = fullEnglish
                                        }
                                      )
                                    ]
                            }
                    }
                  )
                , ( "sausage"
                  , { label = "Sausage"
                    , tree =
                        Parent
                            { label = "How hungry are you?"
                            , alternatives =
                                Dict.fromList
                                    [ ( "normal"
                                      , { label = "Average"
                                        , tree = quiche
                                        }
                                      )
                                    , ( "very"
                                      , { label = "Very hungry"
                                        , tree = fullEnglish
                                        }
                                      )
                                    ]
                            }
                    }
                  )
                ]
        }


lunch : DecisionTree
lunch =
    Parent
        { label = "What are you in the mood for?"
        , alternatives =
            Dict.fromList
                [ ( "salad"
                  , { label = "Salad"
                    , tree = salad
                    }
                  )
                , ( "soup"
                  , { label = "Soup"
                    , tree = soup
                    }
                  )
                ]
        }


supper : DecisionTree
supper =
    Parent
        { label = "What are you in the mood for?"
        , alternatives =
            Dict.fromList
                [ ( "beef"
                  , { label = "Beef"
                    , tree = stroganoff
                    }
                  )
                , ( "chicken"
                  , { label = "Chicken"
                    , tree = satay
                    }
                  )
                , ( "seafood"
                  , { label = "Seafood"
                    , tree = paella
                    }
                  )
                ]
        }


fullEnglish : DecisionTree
fullEnglish =
    Leaf
        { label = "Full English Breakfast"
        , detail = Just "full-english.md"
        }


muffins : DecisionTree
muffins =
    Leaf
        { label = "Banana Oat Muffins"
        , detail = Just "muffins.md"
        }


omelet : DecisionTree
omelet =
    Leaf
        { label = "Cheese Omelet"
        , detail = Just "omelet.md"
        }


paella : DecisionTree
paella =
    Leaf
        { label = "Half-hour Paella"
        , detail = Just "paella.md"
        }


salad : DecisionTree
salad =
    Leaf
        { label = "Gulf Coast Salad"
        , detail = Just "salad.md"
        }


satay : DecisionTree
satay =
    Leaf
        { label = "Lemongrass Chicken Satay"
        , detail = Just "satay.md"
        }


soup : DecisionTree
soup =
    Leaf
        { label = "Chorizo Soup"
        , detail = Just "soup.md"
        }


quiche : DecisionTree
quiche =
    Leaf
        { label = "Sausage and Potato Quiche"
        , detail = Just "quiche.md"
        }


stroganoff : DecisionTree
stroganoff =
    Leaf
        { label = "Meatball Stroganoff"
        , detail = Just "stroganoff.md"
        }
