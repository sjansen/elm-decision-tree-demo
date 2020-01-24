module Page.Decision exposing (view)

import DecisionTree exposing (Decision)
import Html.Styled exposing (Html, h2, text)


view : Decision -> Html msg
view decision =
    h2 [] [ text decision.label ]
