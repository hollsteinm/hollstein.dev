module Style exposing (appBody, appLogo, article, flexChild, flexContainerColumns, flexContainerRows, footer, h1, h2, h3, h4, h5, header, main_, nav, onClickPreventDefault, p, section, sectionWordy, sectionGroup, theme)

import Css exposing (Color, Style, display, none, absolute, alignItems, auto, backgroundColor, batch, borderRadius, calc, center, color, column, displayFlex, em, flex, flexBasis, flexDirection, flexEnd, flexGrow, flexStart, flexWrap, fontFamilies, fontSize, fontWeight, height, hex, hidden, int, justifyContent, margin, margin2, marginLeft, marginRight, maxHeight, maxWidth, minHeight, minus, overflow, padding, padding2, paddingLeft, paddingRight, pct, position, px, row, stretch, top, vh, width, wrap)
import Css.Media as Media exposing (withMedia, only, screen)
import Css.Transitions as Transitions exposing (linear, transition, easeIn)
import Html.Styled as Styled exposing (Attribute, Html, div, footer, header, img, main_, nav, p, styled)
import Html.Styled.Attributes exposing (alt, css, src, title)
import Html.Styled.Events exposing (custom)
import Json.Decode exposing (succeed)


theme : { primary : Color, secondary : Color, highlight : Color, background : Color }
theme =
    { primary = hex "fdb232"
    , secondary = hex "02b8a2"
    , highlight = hex "fdd400"
    , background = hex "01535f"
    }


fontTheme : Style
fontTheme =
    fontFamilies [ "courier", "serif" ]


headerFontTheme : Style
headerFontTheme =
    fontFamilies [ "verdana", "sans-serif" ]



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
        , color theme.primary
        , fontTheme
        , overflow hidden
        , height (vh 100)
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
            , withMedia [only screen [Media.maxWidth (px 719)]] [ display none ]]
        ]
        []


main_ : List (Attribute msg) -> List (Html msg) -> Html msg
main_ =
    styled Styled.main_
        [ paragraphFont
        , flexChild
        , flexContainerColumns
        , overflow auto
        , transition
            [ Transitions.opacity3 333 0 easeIn
            , Transitions.visibility3 333 0 easeIn
            ]
        , withMedia [ only screen [ Media.maxWidth (px 719) ] ]
            [ padding (Css.em 0)
            , margin2 (em 0) (em 1)
            ]
        , withMedia [ only screen [ Media.minWidth (px 720) ] ]
            [ margin2 (em 2) auto
            , padding (Css.em 2)
            , width (pct 100)
            ]
        ]


header : List (Attribute msg) -> List (Html msg) -> Html msg
header =
    styled Styled.header
        [ backgroundColor theme.background
        , flexChild
        , flexContainerRows
        , alignItems stretch
        , justifyContent stretch
        , headerFontTheme
        , flexGrow (int 0)
        ]


footer : List (Attribute msg) -> List (Html msg) -> Html msg
footer =
    styled Styled.footer
        [ backgroundColor theme.background
        , flexChild
        , headerFontTheme
        , position absolute
        , top (calc (pct 100) minus (em 1.25))
        , height (em 1.25)
        , width (pct 100)
        ]


p : List (Attribute msg) -> List (Html msg) -> Html msg
p =
    styled Styled.p
        [ margin2 (em 1) auto
        , maxWidth (Css.px 630)
        ]


h1 : List (Attribute msg) -> List (Html msg) -> Html msg
h1 =
    styled Styled.h1
        [ color theme.secondary
        , headerFontTheme
        , withMedia [ only screen [ Media.minWidth (px 720) ] ]
            [ fontSize (em 5)
            ]
        ]


h2 : List (Attribute msg) -> List (Html msg) -> Html msg
h2 =
    styled Styled.h1
        [ color theme.secondary
        , headerFontTheme
        ]


h3 : List (Attribute msg) -> List (Html msg) -> Html msg
h3 =
    styled Styled.h1
        [ color theme.secondary
        , headerFontTheme
        ]


h4 : List (Attribute msg) -> List (Html msg) -> Html msg
h4 =
    styled Styled.h1
        [ color theme.secondary
        , headerFontTheme
        ]


h5 : List (Attribute msg) -> List (Html msg) -> Html msg
h5 =
    styled Styled.h1
        [ color theme.secondary
        , headerFontTheme
        ]


nav : List (Attribute msg) -> List (Html msg) -> Html msg
nav =
    styled Styled.nav
        [ flexContainerRows
        , alignItems stretch
        , justifyContent flexEnd
        , flex (int 1)
        , paddingLeft (Css.em 1)
        , paddingRight (Css.em 1)
        , transition
            [ Transitions.visibility3 333 0 linear
            , Transitions.opacity3 333 0 linear
            ]
        ]


sectionGroup : List (Attribute msg) -> List (Html msg) -> Html msg
sectionGroup =
    styled Styled.div
        [ flexContainerRows
        , flexWrap wrap
        , withMedia [ only screen [Media.minWidth (px 720)]]
            [ justifyContent center
            ]
        ]


section : List (Attribute msg) -> List (Html msg) -> Html msg
section =
    styled Styled.section
        [ flexContainerColumns
        , backgroundColor theme.background
        , flexChild
        , margin2 (em 0.5) (em 0.5)
        , padding2 (em 0) (em 1)
        , flexBasis (pct 45)
        , withMedia [ only screen [Media.minWidth (px 720)]]
            [ minHeight (em 14)
            , height (em 14)
            , maxWidth (pct 45)
            ]
        ]
        
sectionWordy : List (Attribute msg) -> List (Html msg) -> Html msg
sectionWordy =
    styled Styled.section
        [ flexContainerColumns
        , backgroundColor theme.background
        , flexChild
        , margin2 (em 0.5) (em 0.5)
        , padding2 (em 0) (em 1)
        , flexBasis (pct 45)
        , withMedia [ only screen [Media.minWidth (px 720)]]
            [ minHeight (em 24)
            , height (em 24)
            , maxWidth (pct 45)
            ]
        ]


article : List (Attribute msg) -> List (Html msg) -> Html msg
article =
    styled Styled.article
        [ displayFlex
        , flexDirection column
        , maxWidth (px 1256)
        , marginLeft auto
        , marginRight auto
        , width (pct 100)
        ]


{-| onClickPreventDefault is not provided in a compatible manner from Html.Events.Extras,
so we must define our own that is Html.Styled.Attribute compatible.
-}
onClickPreventDefault : msg -> Attribute msg
onClickPreventDefault msg =
    custom "click" (succeed { message = msg, stopPropagation = False, preventDefault = True })
