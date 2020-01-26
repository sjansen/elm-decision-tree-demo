module Page.NotFound exposing (view)

import Html.Styled exposing (..)


view : { title : String, content : Html msg }
view =
    { title = ""
    , content =
        h1 [] [ text "Not Found" ]
    }
