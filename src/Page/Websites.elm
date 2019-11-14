module Page.Websites exposing (title, view)

import Html
import Html.Styled exposing (Html, a, article, h3, h4, img, section, text)
import Html.Styled.Attributes exposing (href, src, height)
import Style as Style exposing (p)


title : String
title =
    "Websites"


view : List (Html msg)
view =
    [ p []
        [ text "This section is about all of the websites I publicly manage outside of work. These are all related to hobby projects. Think of this as the center of the web of everything I contribute to."
        ]
    , h3
        []
        [ text "Projects"
        ]
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
    , h3
        []
        [ text "Blogs"
        ]
    , websiteViewItem "Centare"
        "https://www.centare.com/blog"
        "I have contributed blogs for my current employer. These blogs focus heavily on technology and the professional use of it."
        (Just "https://www.centare.com/favicon.ico")
    , websiteViewItem "Troll Purse Blog"
        "https://blog.trollpurse.com" "These are personal contributions as they relate to my hobby game development."
        (Just "https://www.trollpurse.com/favicon.ico")
    , websiteViewItem "Enjoy Game Programming"
        "https://enjoy-game-programming.blogspot.com/"
        "This is an unmaintained blog kept for historical reasons. It is the original blog created for my studies at University."
        Nothing
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
        [ h4 []
            [ a [ href link ]
                [ text name
                ]
            , img [ src iconHref, height 16 ]
                []
            ]
        , p []
            [ text body
            ]
        ]
