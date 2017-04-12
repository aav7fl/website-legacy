---
title: 'Charma - Gamifying the Volunteer Process'
date: '2016-04-27 11:58'
comments: true
image:
  path: /assets/img/2016/04/banner.jpg
  height: 470
  width: 800
alt: Charma homepage
published: true
tag: "large project"
description: "Charma is an open source API and web application that promotes volunteerism. It was produced by Grand Valley State University and sponsored by Microsoft."
amp:
  - YouTube
---

For my last semester at Grand Valley State University, I was part of a fantastic group sponsored by Microsoft to create an open source web API that promoted volunteerism. For our capstone project, Xinyi Ou, Dave Walsh, and I created Charma; an open source API and web application that attempts to gamify the connections between volunteers and charitable organizations.

## Video Overview

{% include video.html
  type="YouTube"
  src="https://www.youtube.com/embed/HWSoWfWqcsU"
%}

### [Source Code](https://github.com/aav7fl/GVSU-capstone-project)

## Abstract

Charma is an open source API and web application that promotes volunteerism. Specifically, Charma facilitates a bidirectional connection between volunteers and the charitable opportunities in their community. In collaboration with a local non-profit called Gamers Outreach, we developed Charma to utilize gamification techniques and engage both charities and volunteers in the process of tracking past and future opportunities. Charma is implemented as an ASP.NET, enterprise level web application that follows both Web API and MVC design protocols. The RESTful API layer accesses data from an Azure hosted server and the web application provides a user-friendly interface. Both the open source API and application is available publicly on GitHub and commits are automatically tested and pushed to production through a continuous deployment pipeline. Technical skills that were gained from the project include programming in the .NET framework and designing a RESTful API.

Many charitable organizations depend on volunteers to drive impact in their communities. Charma is a web application and RESTful API that assists these charities in the process of recruiting and retaining volunteers that will remain engaged in their cause. Within Charma, volunteers can host public profiles that highlight their set of skills and interests, and based on their profile, we match them to charitable organizations that need their help. Additionally, volunteers can use the platform to track their progress in hours toward their volunteering goals. Charities benefit from this tracking model in the continuous feedback that they get from their existing volunteers.

Currently available applications that connect volunteers to charities are mostly static in nature. Volunteers visit the site to sift through a list of charities. Once volunteers have found a charity, the experience is usually considered complete. In contrast, Charma tries to engage volunteers beyond the initial point of contact with a charity. Through gamification techniques and a bidirectional rating system, volunteers are incentivized to return to the application to keep track of their ongoing progress or provide feedback to charities. In addition, they have access to their own volunteering data to understand how their time is spent.

Charma lets charities to have a more dynamic relationship with their volunteers. Charities can see who has volunteered with them in the past and also see who is interested in volunteering with them. This makes the process of finding volunteers for their next project or event simpler. They can also distinguish volunteers that may be more experienced, based on the volunteer’s history and badges. All of these features will invite charities to participate on Charma more often, helping to build a lively community on Charma.

Charma has two main components: the RESTful API and the web application. The RESTful API is available to other developers in case they plan to build additional interfaces on top of what Charma currently offers. Potential extensions built using the API could be a mobile application that allows a volunteer to enter hours while out at the event, or a mobile application that allows charities to approve hours while at the event. The web application component is the web interface that we have already developed that allows users to generate a profile or post and find information about charities.

With the support of our sponsor, Microsoft, we have been fortunate to receive access to enterprise level tools and cloud-based resources to aid in the development of our project. The web application and web API were built with ASP.NET in Visual Studio. Charma is currently hosted as a web service in Azure. The main database as well as other types of storage for the application is also implemented in Azure. Finally, the continuous deployment process is handled through Visual Studio Team Services, a tool that helps us integrate testing and deployment in one pipeline. At the end of the semester, Charma will continue to be available on GitHub as an open source project.

The initial concept for Charma came out of a desire to help charities and volunteers. We wanted to help make the volunteering process even more rewarding. As part of this mission, we strongly believe that applications such as Charma should remain open source for developers and free for the end users, whether they be charities or volunteers. Our hope is that more developers will extend the functionality of Charma in the future.

Throughout our project, we collaborated with Gamers Outreach, a 501(c)(3) non-profit organization and its volunteers to guide us in our design choices. One of our most difficult design choices was deciding on the best way to gamify our application. Some volunteers were hesitant to share anything publicly because they felt it was not tactful. They were also concerned that their volunteerism would be perceived as less altruistic. These were concerns that we continued to address with our application. In our research, we found multiple blueprints for gamification such as badges, leaderboards, unlocks, and tangible goods. We compromised and decided to go with a mix of badges, customized rewards, and tangible goods. Based on our feedback from Gamers Outreach, we found this to be the best way to incentivize volunteers with attainable and desirable rewards.
