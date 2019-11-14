module Style exposing (..)

import Css exposing (..)
import Html
import Html.Styled as Styled exposing (..)
import Html.Styled.Attributes as Attributes exposing (..)


theme : { primary : Color, secondary : Color, highlight : Color, background : Color }
theme =
    { primary = hex "fdb232"
    , secondary = hex "02b8a2"
    , highlight = hex "fdd400"
    , background = hex "01535f"
    }


fontTheme : Style
fontTheme =
    fontFamilies [ "Palatino Linotype", "Georgia", "serif" ]



-- STYLES


paragraphFont : Style
paragraphFont =
    Css.batch
        [ fontTheme
        , fontSize (Css.em 1)
        , fontWeight Css.normal
        ]


flexContainerRows : Style
flexContainerRows =
    Css.batch
        [ displayFlex
        , flexDirection row
        , justifyContent flexStart
        , alignItems flexStart
        ]


flexContainerColumns : Style
flexContainerColumns =
    Css.batch
        [ displayFlex
        , flexDirection column
        , justifyContent flexStart
        , alignItems flexStart
        ]


flexChild : Style
flexChild =
    Css.batch
        [ displayFlex
        , flex auto
        ]



-- ELEMENTS


appBody : List (Attribute msg) -> List (Html msg) -> Html msg
appBody =
    styled div
        [ flexContainerColumns
        , padding (Css.px 0)
        , margin (Css.px 0)
        , alignItems stretch
        ]


appLogo : Html msg
appLogo =
    img
        [ src "assets/face.jpg"
        , title "Martin Hollstein's face."
        , alt "Image of Martin Hollstein's face."
        , css
            [ borderRadius (Css.pct 50)
            , maxWidth (Css.px 128)
            , maxHeight (Css.px 128)
            , padding (Css.em 2)
            ]
        ]
        []


main_ : List (Attribute msg) -> List (Html msg) -> Html msg
main_ =
    styled Styled.main_
        [ margin (Css.em 2)
        , backgroundColor theme.background
        , color theme.primary
        , paragraphFont
        , flexChild
        , flexContainerColumns
        , margin (Css.px 0)
        , padding (Css.em 2)
        ]


header : List (Attribute msg) -> List (Html msg) -> Html msg
header =
    styled Styled.header
        [ backgroundColor theme.highlight
        , flexChild
        , flexContainerRows
        , alignItems stretch
        , justifyContent stretch
        ]


footer : List (Attribute msg) -> List (Html msg) -> Html msg
footer =
    styled Styled.footer
        [ backgroundColor theme.highlight
        , flexChild
        ]


p : List (Attribute msg) -> List (Html msg) -> Html msg
p =
    styled Styled.p
        [ color theme.secondary
        , margin auto
        ,maxWidth (Css.px 628)
        ]

nav : List (Attribute msg) -> List (Html msg) -> Html msg
nav =
  styled Styled.nav
        [ flexContainerRows
        , justifyContent flexEnd
        , flex (int 1)
        , paddingLeft (Css.em 1)
        , paddingRight (Css.em 1)
        ]