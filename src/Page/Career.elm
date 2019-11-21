module Page.Career exposing (title, view)

import Css exposing (alignSelf, flex, int, stretch, flexEnd, justifyContent)
import Html.Styled exposing (Html, a, section, text, span)
import Html.Styled.Attributes exposing (css, href)
import Style exposing (h2, h3, flexChild, flexContainerColumns, flexContainerRows, p)


title : String
title =
    "Career"


view : List (Html msg)
view =
    [ p []
        [ text "Below is a timeline of places I have worked in the technology industry. Following the where, I will briefly discuss the what. If you are looking for more detail, please visit the link below."
        , a [ href "https://www.linkedin.com/in/martin-hollstein" ]
            [ text "LinkedIn Profile"
            ]
        ]
    , h2 []
        [ text "Certifications"
        ]
    , p []
        [ text "AWS Solutions Architect - Professional"
        ]
    , h2 []
        [ text "Career Employment"
        ]
    , timelineItemView "Centare"
        "Centare is my current place of employment. It is here that I have established experience in the e-commerce, financial, insurance, and aeronautics technology spaces. This website is not related to Centare and all thoughts, opinions and views expressed on this website are of my own and in no way reflect the thoughts views and opinions of Centare."
        "Current"
    , timelineItemView "RFT"
        "RFT was my first full time position as a developer. It is here that the architects groomed and mentored me to the pragmatic and solid developer I am today. This job introduced me to developing software for the healthcare, security, and safety industries."
        "2 years"
    , timelineItemView "iStream Financial Services"
        "iStream was my second internship position. It is here that I established good data practices. This work exposed me to technology as it relates to financial institutions and electronic check transfers."
        "1 year"
    , timelineItemView "EverFire Studios"
        "EverFire was an internship developing video games. It is here that I was first introduced to realtime client server interactions and client side prediction. The studio is no longer active."
        "2 years"
    , timelineItemView "Notion Games, LLC"
        "Notion Games, LLC was my first ever remote position. It was also my first time contributing to video game prototypes for an established studio. While my work was not adopted, it was still a pleasure to work with them."
        "1 year"
    ]


timelineItemView : String -> String -> String -> Html msg
timelineItemView place description dateString =
    section [ css [ flexContainerColumns ] ]
        [ h3 [ css [ flexContainerRows, flex (int 1), alignSelf stretch ] ]
            [ span [ css [ flexChild ] ]
                [ text place
                ]
            , span [ css [ flexChild, justifyContent flexEnd ] ]
                [ text dateString
                ]
            ]
        , p []
            [ text description
            ]
        ]
