module Page.Connect exposing (title, view)

import Css exposing (alignSelf, flex, stretch, int, maxWidth, px)
import Html.Styled exposing (Html, a, img, section, text)
import Html.Styled.Attributes exposing (css, height, href, src, width, target)
import Style exposing (h2, h3, flexChild, flexContainerColumns, flexContainerRows, p)


title : String
title =
    "Connect"


view : List (Html msg)
view =
    [ p []
        [ text "If you want to get in touch, here are the channels to reach me by."
        ]
    , h2 []
        [ text "Professional Websites"
        ]
    , connectViewItem "GitHub"
        "https://www.github.com/hollsteinm"
        "I am active on GitHub, contributing both for pleasure and business. I am a member of Centare, Troll Purse, and Epic Games (for Unreal Engine 4). I am an active contributor within all of these groups. You will also find old scholl projects."
        "https://avatars3.githubusercontent.com/u/6885891?s=40&v=4"
    , connectViewItem "LinkedIn"
        "https://www.linkedin.com/in/martin-hollstein"
        "I actively check LinkedIn. If you send me a generic recruitment message you will be blocked. Also, things (kegs, ping pong, etc.) do not prove culture or enjoyment at a job for myself. Also, I love where I work right now."
        "https://media.licdn.com/dms/image/C4E03AQGTGeVKM_nllA/profile-displayphoto-shrink_100_100/0?e=1579132800&v=beta&t=zC9Iha4G-LWFxEPFdkxjzzXccABA_boHYyntSpE2nJs"
    ]


connectViewItem : String -> String -> String -> String -> Html msg
connectViewItem name link body imageHref =
    section [ css [ flexContainerColumns ] ]
        [ h3 [ css [ flexContainerRows, flex (int 1), alignSelf stretch ] ]
            [ a [ href link, target "_blank", css [ flexChild ] ]
                [ text name
                ]
            , img [ src imageHref, height 32, width 32, css [ flexChild, maxWidth (px 32) ] ]
                []
            ]
        , p [ css [ flexChild ] ]
            [ text body
            ]
        ]
