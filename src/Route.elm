module Route exposing (Route(..), fromUrl)

import Url exposing (Url)
import Url.Parser as UrlParser exposing ((</>), Parser, map, oneOf, s, string, top)


type Route
    = Root
    | Answers (List String)


fromUrl : Url -> Maybe Route
fromUrl url =
    url |> UrlParser.parse parser


parser : Parser (Route -> a) a
parser =
    oneOf
        [ map Root top
        , map Answers (s "t" </> rest)
        ]


rest : Parser (List String -> a) a
rest =
    restEven 100


restEven : Int -> Parser (List String -> a) a
restEven maxDepth =
    if maxDepth < 1 then
        map [] top

    else
        oneOf
            [ map [] top
            , map (\str li -> str :: li) (string </> restOdd (maxDepth - 1))
            ]


restOdd : Int -> Parser (List String -> a) a
restOdd maxDepth =
    if maxDepth < 1 then
        map [] top

    else
        oneOf
            [ map [] top
            , map (\str li -> str :: li) (string </> restEven (maxDepth - 1))
            ]
