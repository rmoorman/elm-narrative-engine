module Components.Storyline exposing (..)

import Html exposing (..)
import Html.Keyed
import Html.Attributes exposing (..)
import Markdown
import StoryElements exposing (..)


storyline : StoryElementsConfig a -> List ( a, String ) -> Html msg
storyline storyElements storyLine =
    let
        storyItem i ( storyElement, storyText ) =
            let
                numLines =
                    List.length storyLine

                key =
                    (toString storyElement) ++ (toString <| numLines - i)

                classes =
                    [ ( "Storyline__Item", True )
                    , ( "u-fade-in", i == 0 )
                    ]
            in
                ( key
                , li [ classList classes ]
                    [ h4 [ class "Storyline__Item__Action" ] <| [ text <| getName storyElements storyElement ]
                    , Markdown.toHtml [ class "Storyline__Item__Narration" ] storyText
                    ]
                )
    in
        Html.Keyed.ol [ class "Storyline" ]
            (List.indexedMap storyItem storyLine)