module Page.NotFound exposing (view)

import Html.Styled exposing (Html, h2, text)


view : Html msg
view =
    h2 [] [ text "Not Found" ]
