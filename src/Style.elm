module Style exposing (appBody, appLogo, article, flexChild, flexContainerColumns, flexContainerRows, footer, h1, h2, h3, h4, h5, sectionGroup, header, main_, nav, p, section, theme, backgroundLeft, backgroundRight, backgroundCenter)

import Css exposing (Color, Style, flexWrap, wrap, center, left, solid, zIndex, borderRight3, borderLeft3, borderTop3, transparent, absolute, alignItems, auto, backgroundColor, batch, borderRadius, calc, color, column, displayFlex, em, flex, flexBasis, flexDirection, flexEnd, flexGrow, flexStart, fontFamilies, fontSize, fontWeight, height, hex, hidden, int, justifyContent, margin, margin2, marginLeft, marginRight, maxHeight, maxWidth, minHeight, minus, overflow, padding, padding2, paddingLeft, paddingRight, pct, position, px, row, stretch, top, vh, width)
import Html.Styled as Styled exposing (Attribute, Html, div, footer, header, img, main_, nav, p, styled)
import Html.Styled.Attributes exposing (alt, css, src, title)


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
            ]
        ]
        []


main_ : List (Attribute msg) -> List (Html msg) -> Html msg
main_ =
    styled Styled.main_
        [ margin2 (em 2) auto
        , paragraphFont
        , flexChild
        , flexContainerColumns
        , padding (Css.em 2)
        , width (pct 100)
        , overflow auto
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
        ]


sectionGroup : List (Attribute msg) -> List (Html msg) -> Html msg
sectionGroup =
    styled Styled.div
        [ flexContainerRows
        , flexWrap wrap
        , justifyContent center
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
        , minHeight (em 12)
        , height (em 12)
        , maxWidth (pct 45)
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


backgroundCenter : Html msg
backgroundCenter =
    div
        [ css
            [ position absolute
            , top (px 0)
            , left (px 0)
            , width (pct 100)
            , height (pct 100)
            , backgroundColor theme.highlight
            , zIndex (int -100)
            , overflow hidden
            ]
        ]
        []


backgroundRight : Html msg
backgroundRight =
    div
        [ css
            [ position absolute
            , top (px 0)
            , left (px 0)
            , width (px 0)
            , height (px 0)
            , zIndex (int -99)
            , borderTop3 (px 1920) solid theme.secondary
            , borderLeft3 (px 1920) solid transparent
            , overflow hidden
            ]
        ]
        []


backgroundLeft : Html msg
backgroundLeft =
    div
        [ css
            [ position absolute
            , top (px 0)
            , left (px 0)
            , width (px 0)
            , height (px 0)
            , zIndex (int -98)
            , borderTop3 (px 1256) solid theme.primary
            , borderRight3 (px 1256) solid transparent
            , overflow hidden
            ]
        ]
        []
