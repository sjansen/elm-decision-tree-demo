module Page exposing (Page)

import DecisionTree exposing (DecisionTree)


type alias Page =
    { tree : DecisionTree
    , path : String
    }
