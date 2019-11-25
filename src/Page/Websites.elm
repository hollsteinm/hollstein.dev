module Page.Websites exposing (title, view)

import Css exposing (textDecoration, margin2, color, visited, hover, alignSelf, em, flex, flexWrap, int, none, maxWidth, px, stretch, wrap, justifyContent, center)
import Html.Styled exposing (Html, a, div, img, text)
import Html.Styled.Attributes exposing (css, height, href, src, target, width)
import Style exposing (theme, flexChild, flexContainerRows, h2, h3, p, section)


title : String
title =
    "Websites"


view : List (Html msg)
view =
    [ p [ css [ margin2 (em 1) (em 0) ] ]
        [ text "This section is about all of the websites I publicly manage or contribute to outside of work. These are all related to hobby or volunteer projects. Think of this as the center of the web of everything I contribute time towards."
        ]
    , h2
        []
        [ text "Projects"
        ]
    , div [ css [ flexContainerRows, flexWrap wrap, justifyContent center ] ]
        [ websiteViewItem "Cream City Code / FallX"
            "https://www.fallexperiment.com"
            "This was a joint effort created by Cream City Code volunteers for the Fall Experiment / Cream City Code conference in Milwaukke, WI. I contributed time to exploratory features and frontend work."
            (Just "https://fallexperiment.com/icons/icon-48x48.png")
        , websiteViewItem "MnM Adventureel"
            "https://www.mnmadventureel.com"
            "A website that showcases the travelling that fullfills my life. One of the greatest experiences we can have is engaging with the world around us. Beyond that, sharing it with others can bring joy."
            (Just "https://www.mnmadventureel.com/icons/icon-48x48.png")
        , websiteViewItem "Eight Hours"
            "https://www.eighthoursgame.com"
            "A video game website for a hobby project of mine. I enjoy making games and I wanted to make a 'Classic Indie Horror' game with a slight twist. This project also involves working with local paranormal groups."
            Nothing
        , websiteViewItem "Troll Purse"
            "https://www.trollpurse.com"
            "A website containing a collection and links to storefronts for all of my hobby video game projects."
            Nothing
        , websiteViewItem "World of Phyntasie"
            "https://www.worldofphyntasie.com"
            "A text adventure game that is hosted client side. A small project to excercise my creative story telling."
            Nothing
        , websiteViewItem "Hollstein.Dev"
            "https://www.hollstein.dev"
            "This website. Not much else to say about it. A good way to show off a portfolio of my work."
            Nothing
        ]
    , h2
        []
        [ text "Blogs & Articles"
        ]
    , div [ css [ flexContainerRows, flexWrap wrap, justifyContent center ] ]
        [ websiteViewItem "Centare"
            "https://www.centare.com/blog"
            "I have contributed blogs for my current employer. These blogs focus heavily on technology and the professional use of it."
            (Just "https://www.centare.com/favicon.ico")
        , websiteViewItem "Troll Purse Blog"
            "https://blog.trollpurse.com"
            "These are personal contributions as they relate to my hobby game development."
            (Just "https://www.trollpurse.com/favicon.ico")
        , websiteViewItem "Enjoy Game Programming"
            "https://enjoy-game-programming.blogspot.com/"
            "This is an unmaintained blog kept for historical reasons. It is the original blog created for my studies at University."
            Nothing
        , websiteViewItem "Gamedev.net"
            "https://www.gamedev.net/articles/programming/general-and-gameplay-programming/unreal-engine-4-c-quest-framework-r4316"
            "This is a peer approved article introducing to beginners a method to create object interactions within the Unreal Engine 4 game engine."
            (Just "https://www.gamedev.net/static/favicon.ico")
        ]
    ]


websiteViewItem : String -> String -> String -> Maybe String -> Html msg
websiteViewItem name link body maybeIcon =
    let
        iconHref =
            case maybeIcon of
                Just value ->
                    value

                Nothing ->
                    link ++ "/favicon.ico"
    in
    section []
        [ h3 [ css [ flexContainerRows, flex (int 1), alignSelf stretch ] ]
            [ a [ href link, target "_blank", css
            [ flexChild
            , textDecoration none
            , color theme.secondary
            , visited
                [ color theme.secondary
                ]
            , hover
                [ color theme.highlight
                ]
            ]
                ]
                [ text name
                ]
            , img [ src iconHref, height 32, width 32, css [ flexChild, maxWidth (px 32) ] ]
                []
            ]
        , p [ css [ flexChild ] ]
            [ text body
            ]
        ]
