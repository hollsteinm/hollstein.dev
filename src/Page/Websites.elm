module Page.Websites exposing (title, view)

import Css exposing (alignSelf, color, em, flex, hover, int, margin2, maxWidth, none, px, stretch, textDecoration, visited)
import Html.Styled exposing (Html, a, img, text)
import Html.Styled.Attributes exposing (css, height, href, src, target, width)
import Style exposing (flexChild, flexContainerRows, h2, h3, p, section, sectionWordy, sectionGroup, theme)

title : String
title =
    "Projects"


view : List (Html msg)
view =
    [ p [ css [ margin2 (em 1) (em 0), color theme.background ] ]
        [ text "The projects section lists all games, websites, blogs & articles, software projects, presentations of note I have participated in or developed since 2010. My GitHub profile and University blog will contain my oldest works. My presentations are newer as I have adopted that as a new interest. My GitHub will also have newer projects that are pinned."
        ]
    , h2
        [ css [color theme.background ] ]
        [ text "Games"
        ]
    , sectionGroup []
        [ websiteViewItem "Eight Hours"
            "https://trollpurse.itch.io/eighthours"
            "This is a game I have been working on solo since 2016. I am using Unreal Engine 4 and source assets from purchases in the UE4 Marketplace. The programming, design, and development are done by myself."
            (Just "https://img.itch.zone/aW1nLzE4NjQ4MjcucG5n/32x32%23/qphIbA.png")
        , websiteViewItem "World of Phyntasie"
            "https://www.worldofphyntasie.com"
            "A text adventure game that is hosted client side. A small project to excercise my creative story telling. This project used to be a .NET based MuD. Our peak user base was over 200 registered players. It is now a single player adventure."
            Nothing
        ]
    , h2
        [ css [ color theme.background ] ]
        [ text "Websites"
        ]
    , sectionGroup []
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
            (Just "assets/face.jpg")
        ]
    , h2
        [ css [ color theme.background ] ]
        [ text "Blogs & Articles"
        ]
    , sectionGroup []
        [ websiteViewItem "Centare"
            "https://www.centare.com/blog"
            "I have contributed blogs for my current employer. These blogs focus heavily on technology and the professional use of it. My discussions forcus around AWS Security and Architecture as well as a soft introduction to GraphQL."
            (Just "https://www.centare.com/favicon.ico")
        , websiteViewItem "Troll Purse Blog"
            "https://blog.trollpurse.com"
            "These are personal contributions as they relate to my hobby game development. Most of the blogs will focus on the active development of hobby projects"
            (Just "https://www.trollpurse.com/favicon.ico")
        , websiteViewItem "Enjoy Game Programming"
            "https://enjoy-game-programming.blogspot.com/"
            "This is an unmaintained blog kept for historical reasons. It is the original blog created for my studies at University. The most popular article had a peak viewer count of over 1000 individuals within the first week."
            Nothing
        , websiteViewItem "Gamedev.net"
            "https://www.gamedev.net/martin-h-hollstein/#profiletutorials"
            "A list of several peer approved tutorial contributions with a focus on Unreal Engine 4. GameDev.net is a video game industry community website with a large active user base."
            (Just "https://www.gamedev.net/static/favicon.ico")
        ]
    , h2
        [ css [ color theme.background ] ]
        [ text "Software Projects"
        ]
    , sectionGroup []
        [ websiteViewItem "CoronaFold"
            "https://github.com/CentareGroup/folding-at-centare"
            "During 2019 COVID-19 struck, it started to show it's impact in Wisonsin around March 2020. With our extra time due to working from our home offices, myself and other Centarians, started a project that will utilize our free monthly Azure Credits to support Folding @ Home. This project supports research in fitting COVID-19 and other diseases."
            (Just "https://github.com/fluidicon.png")
         , websiteViewItem "Hollstein.Dev Source"
            "https://github.com/hollsteinm/hollstien.dev"
            "Recently, I have been interested in learning functional programming languages. This website is built entirely in Elm and deployed via AWS CodePipelines - like the majority of my websites."
            (Just "https://github.com/fluidicon.png")
        ]
    , h2
        [ css [ color theme.background ] ]
        [ text "Presentations"
        ]
    , sectionGroup []
        [ textViewItem "Coding With a Centarian: GraphQL Server"
            "June 26th, 2020"
            "Coding with a Centarian (CwaC) is a livestream hosted by Centare where two developers pair program as a student and teacher focused on a specific technology. For this CwaC I instructed on how to implement a GraphQL server in Node using Apollo Server. There were several implementation and design discussions as well."
         , textViewItem "Webinar: The Cost of a GraphQL Migration"
            "June 17th, 2020"
            "I presented a Webinar about GraphQL from an executive level. The discussion focused on where opportunities to generate revenue via leveraging GraphQL, what will be the costs of implementing GraphQL, and the technical cost and preperations discussions required to begin a migraiton or adoption of GraphQL APIs. This discussion resulted in a checklist of key discussions points when teams want to discuss migration or adoption of GraphQL APIs."
         , textViewItem "Up and Running with Phoenix Framework"
            "January 24th, 2019"
            "Forward Thinkings are presentations discussing rising technology trends, stacks, and practices. In this presentation I walk through the basics of Elixir and the process needed to bootstrap a Pheonix Web Server. The second part of the presentation focused on implementing a few pages and features of a basic MVC application using Phoenix. I also touched on realtime components using Phoenix Channels."
        ]
    ]

textViewItem : String -> String -> String -> Html msg
textViewItem name date body =
  sectionWordy []
        [ h3 [ css [ flexContainerRows, flex (int 1), alignSelf stretch ] ]
            [ p
                [
                  css
                    [ flexChild
                    , textDecoration none
                    , color theme.secondary
                    ]
                ]
                [ text name
                ]
            , p [
                  css [ flexChild ]
                ]
                [ text date
                ]
            ]
        , p [ css [ flexChild ] ]
            [ text body
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
            [ a
                [ href link
                , target "_blank"
                , css
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
