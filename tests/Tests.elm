module Tests exposing (all)

import DecisionTree exposing (DecisionTree(..))
import Expect
import Maybe exposing (Maybe(..))
import Route exposing (Route(..))
import Test exposing (..)
import Trees exposing (recipes)



-- Check out https://package.elm-lang.org/packages/elm-explorations/test/latest to learn more about testing in Elm!


all : Test
all =
    Test.describe "Walking A Tree"
        [ test "URL Parsing" <|
            \_ ->
                Expect.equal
                    (Just (Tree [ "breakfast", "eggs" ]))
                    (Route.fromString "https://example.com/t/breakfast/eggs")
        ]
