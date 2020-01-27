module Page.Question exposing (Model, init, view)

import DecisionTree exposing (Question, eachAlternative)
import Html.Styled exposing (..)
import Html.Styled.Attributes exposing (..)


type alias Model =
    { question : Question
    , status : Status
    }


type Status
    = Ready


init : Question -> Model
init question =
    { question = question
    , status = Ready
    }


view : Model -> { title : String, content : Html msg }
view model =
    { title = ""
    , content =
        div []
            [ h1 [] [ text model.question.label ]
            , ul []
                (eachAlternative
                    (\k v l ->
                        li [] [ a [ href (k ++ "/") ] [ text v.label ] ] :: l
                    )
                    []
                    model.question.alternatives
                )
            ]
    }
