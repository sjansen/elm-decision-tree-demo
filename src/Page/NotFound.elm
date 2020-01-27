module Page.NotFound exposing (Model, init, view)

import Html.Styled exposing (..)


type Model
    = Ready


init : Model
init =
    Ready


view : Model -> { title : String, content : Html msg }
view _ =
    { title = ""
    , content =
        h1 [] [ text "Not Found" ]
    }
