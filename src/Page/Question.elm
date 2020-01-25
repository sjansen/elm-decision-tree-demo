module Page.Question exposing (view)

import DecisionTree exposing (Question, eachAlternative)
import Html.Styled exposing (Html, a, div, h1, li, text, ul)
import Html.Styled.Attributes exposing (href)


view : Question -> Html msg
view question =
    div []
        [ h1 [] [ text question.label ]
        , ul []
            (eachAlternative
                (\k v l ->
                    li [] [ a [ href (k ++ "/") ] [ text v.label ] ] :: l
                )
                []
                question.alternatives
            )
        ]
