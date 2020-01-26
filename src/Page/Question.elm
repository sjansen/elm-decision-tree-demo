module Page.Question exposing (view)

import DecisionTree exposing (Question, eachAlternative)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)


view : Question -> { title : String, content : Html msg }
view question =
    { title = ""
    , content =
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
    }
