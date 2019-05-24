---
title: "Trading in Nest for TensorFlow and Z-Wave"
date: "2019-05-24 17:39"
comments: true
image:
  path: /assets/img/2019/05/2019-05-23_18-58-26.jpg
  height: 450
  width: 800
alt: Detecting two people at once in TensorFlow
published: true
tag: "large project"
description: "I replaced my Nest products with cheaper cameras using TensorFlow and a locally controlled in Z-Wave thermostat."
---

A few weeks ago, Google [announced the shutdown](https://blog.google/products/google-nest/helpful-home/) of its Works with Nest developer program only 16 weeks in advance. The Works with Nest program allows third-party applications like Home Assistant and IFTTT to integrate with Nest products. Without this ability to integrate, Nest products are worthless to me.

After much outcry, Google decided to [back off](https://blog.google/products/google-nest/updates-works-with-nest/) on their aggressive shutdown target date. They also clarified that services like Alexa would be exempt from this change. Unfortunately, the death sentence has only been extended and without a doubt will still be shutdown in the near future.

## What's Wrong with Nest

I like Nest. Their support has always been top-notch. When I first purchased my Nest E thermostat, the customer service paid to have an electrician rewire our HVAC to be compatible. I've been recommending them for years because of that experience. It hit me like a train when they announced they were winding down their developer program. All I could think about was how I wasn't going to be able to use their products the way _I_ wanted to, but the way _they_ wanted me to.

## What Can I Fix

I know what you're thinking. I made a terrible decision going with the company that had a cloud-based API. You're mostly correct. However, when I purchased the Nest products, it made sense. I didn't have any home automation platforms, and I didn't have the time to build one during my moving situation.

> Going forward, I will favor edge computing and APIs that can be accessed locally.

Knowing full well that I was in need of a new solution, I started looking at what problems I was  having and how I could improve with the next iteration.

### Problem 1: Avoid Cloud APIs Like the Plague

My thermostat needed to be replaced if I was to continue using it in the same way. A device that usually stays in your house for _decades_ hadn't passed its second birthday. I _thrilled_ to be buying a new thermostat so soon.

This transformation led me down the path of seeking [Z-Wave](https://en.wikipedia.org/wiki/Z-Wave), a wireless communications protocol commonly used in home automation. I was seeking full control of a device that I could communicate with even if the Internet went out. This meant avoiding Wi-Fi based thermostats because I felt that most of the options weren't that great unless I was ready to spend large sums of money. I was still getting over the burn of my Nest E thermostat purchase.

After digging through a few reviews and recommendations, I settled upon the Radio Thermostat CT101. Honestly, it looks like it came out of the 1980s. It's ugly-- but it _is_ functional.. So.. ✅? I guess..

![My thermostat that fell out of 1982](/assets/img/2019/05/2019-05-21_20-05-12.jpg)*My thermostat that fell out of 1982*

A quick installation of the new thermostat and I was good to go. Within an hour I had it paired with my Z-Wave stick on my Home Assistant, and another two hours later I had completed flows in Node-RED for temperature scheduling and home/away temperatures.

### Problem 2: Cameras Shouldn't Break Without Internet

The Nest camera had a critical flaw. If the Internet went out, it stopped working!

It was essential that I replace the Nest camera with one that allowed for local streaming and recording to the device if something went down.

Instead of throwing more money at the problem, I decided to go the hobbyist route. After getting some strong recommendations for [Wyze 2 cameras](https://www.amazon.com/dp/B076H3SRXG) from my coworkers, I decided to pick one up.

I was excited to use the Wyze 2 camera because they recently announced their beta firmware was adding support for [RTSP](https://en.wikipedia.org/wiki/Real_Time_Streaming_Protocol). This feature would allow me to stream the network video to any local device that I wanted, bypassing the Internet completely.

![Wyze 2 Camera](/assets/img/2019/05/2019-05-24_19-04-27.jpg)*The Wyze 2 in its full glory*

There isn't too much to say about them. They are _super cheap_ and it shows. It doesn't have a 130° wide-angle lens that my Nest camera had. The compression in the video is pretty extreme. It also seems unable to fully illuminate the room with its weak infrared lamps.

At the end of the day, it's less than 1/8 the price of the cheapest Nest camera. It has no subscription cost, doesn't require Internet, and can record locally on an SD card. If it really bothers me, I can pick up half a dozen more before it approaches the same price of my Nest camera.

So the cheap Wyze 2 camera wins for today.

### Problem 3: Roomba is My Pet

On quite a few occasions, my Nest camera would send me `Person` alerts when it saw my Roomba by chugging along. Nest wasn't the only one who didn't recognize the Roomba though. Support thought it was my pet! _Although they might be partially correct on that_...

![Chat conversation with Gary from customer support](/assets/img/2019/05/2019-05-07-09-21-17.png)*Is Roomba your pet?*

What can I do to fix this? A few months back, I remembered that Home Assistant had announced support for TensorFlow as an integration. Given that I had recently moved my entire set up onto an Intel NUC, I figured this would be an excellent usage of my extra CPU cycles.

My plan was to stream everything locally, run motion detection on the images, hand them off to TensorFlow, and check to see if any unexpected humans were in frame.

This was kind of like playing the [Not HotDog](https://itunes.apple.com/us/app/not-hotdog/id1212457521) game from Silicon Valley. The critically acclaimed app determines whether an object is a hot dog, or _not_ a hot dog.

I wasn't trying to categorize every kind of object in every single frame. I just wanted to know if anything in frame was either human, or _not_ human. A _fairly simple_ model to deal with.

#### Approaching Human/Not Human

Here was the plan:

- Use Wyze 2 camera with RTSP enabled
- Capture the RTSP stream inside _something_
- Detect motion so I'm not running TensorFlow 24x7
- Send me a notification if there is a person (who shouldn't be there)

In under a few seconds I should be able to detect a person walking near a camera and be immediately notified of their presence. I still don't know _who_ the person is, but I can't imagine it's too difficult to capture faces from TensorFlow and send them through a trained network of known faces.

> I decided to use the [faster_rcnn_inception_v2_coco](https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/detection_model_zoo.md) model based on the [recommendation from this post](https://josiahvorst.com/image-processing-made-easy-home-assistant-tensorflow/).

The best part about my plan is that all of it (except the Pushover notification) was supposed to be handled locally.

### Taking My Camera to the Next Level

With my bundle of new cameras, it was time to make them smart. I set up a camera in the front of my house to keep an eye on my car and track people approaching the front door. My original plan was to use the outline mentioned above and notify me via Pushover when it detects a person. But it seemed to work a little too well...

![Person on the other side of the road](/assets/img/2019/05/2019-05-23_17-35-27.jpg)*That person is pretty far away*

While testing, I was noticing that it was picking up people all the way across the street.

_Ok_. I guess I can handle this by restricting the area that tensor flow is looking at. So let me chop off the top 35% of the image area.

![I duck to trigger a valid capture](/assets/img/2019/05/2019-05-23_17-49-29.jpg)*Ducking to trigger a valid event*

_Ok_. Now it only works if the person happens to crawl up to my window. Because my camera isn't high enough, it doesn't know when a person's head is in the foreground or the background and it can't efficiently detect them.

#### Solving the Depth Perception

Ironically, Google AI _JUST_ put out a [blog post about depth prediction](https://ai.googleblog.com/2019/05/moving-camera-moving-people-deep.html). But I don't think that would've worked very well in my cheap cameras.

What do you notice when a person gets closer to the camera? The bounding box TensorFlow provides becomes larger. Because TensorFlow is already giving me `xmin`/`xmax`/`ymin`/`ymax`, I can calculate the `area` of the bounding box to get a rough estimate if target is closer or farther away from the camera.

I set up a Node-RED prototype flow to log the `area`, grabbed my iPad, and ran outside. I repeatedly triggered the capture so TensorFlow produce the `area` result based on where I was standing.

I stood on one side of the sidewalk, hit the button, and took note of the `area` result. Then I stood by my car and repeated the process. I kept doing this for a handful of different locations while striking beautiful poses to give the system a variety. After a few minutes, I had a good idea of what kind of `area` numbers I needed for determiners on distance from the camera.

![Example capture of two people](/assets/img/2019/05/2019-05-23_18-58-26.jpg)*What if there is more than one person?*

_Ok_. But what if there are two people in frame, and they are really far away from each other? While testing out my flow, I realized that if there was more than one person in frame, and the first person I detect is too far away, my entire flow would stop after the first failure. With a little bit of JavaScript-fu I needed to break apart all of the returned objects from TensorFlow. This allowed me to address each result individually to know if it met all criteria.

![My Node-RED flow](/assets/img/2019/05/2019-05-24_15-30-19.png)*My Node-RED flow for the outdoor camera: ([front-window-node-red-flow.js](/assets/files/2019/05/front-window-node-red-flow.js))*

Success! It's finally working.

#### Camera Setup

1. A Wyze 2 camera is recording and streaming a scene through RTSP.
2. The stream is picked up by [motionEye](https://github.com/ccrisan/motioneye) which:
   1. _Re-broadcasts_ the stream to Home Assistant as MJPEG (so I'm not picking the stream up twice from each camera increasing the load on them).
   2. Calls a webhook in Home Assistant for the start of each motion event.
3. The Home Assistant webhook sends a MQTT message for every new motion event.
4. In Node-RED, I pick up the MQTT messages and treat them like a stream.
   - If the messages keep coming in, continue running TensorFlow on a camera stream.
   - If the messages stop, my timer runs out and I stop running TensorFlow on the camera stream.
5. If TensorFlow detects a person:
   1. Split up all person objects into separate results.
   2. Check the confidence level of each result. If it's not high enough, ignore it. If it is high enough, continue.
   3. Check the total area of each results. If the total area exceeds something that I would deem close to the camera, continue.
6. If there is a captured result from TensorFlow that passes all of my validations, notify me with the image via Pushover. Or at the very least, log the image somewhere that I can review later.

#### Outdoor Camera Flow

Essentially, this is the outdoor camera flow simplified:

- Everyone is gone
  - Movement is detected
    - Movement looks like a person?
    - The confidence level of the person is fairly high?
    - The area of the detected person is fairly large?
    - Send me a low priority alert with the image

#### Indoor Camera Flow

The inside camera flow is laughably easier:

- Everyone is gone
  - Movement is detected
    - Movement looks like a person?
    - Take evasive actions!

## Final Thoughts

I'm sad to leave Nest. They have beautiful products that work very well. Well... _technically_ since Google has re-branded the Home Hub as the Nest Hub, I haven't _exactly_ left them. But that doesn't make a very good title, does it?

I'm excited to use edge computing rather than cloud computing for analysis. I'm enjoying my approach of  decoupling my home automation from being Internet reliant. Unlike Nest cameras, my devices will *still have basic functionality* if there is an internet outage. More problems have been solved that I hope do not crop up again.

This was a fun project to apply TensorFlow data models on low-budget cameras to gain (in my opinion)  superior image recognition. I continue my quest of home automation with more lessons learned. Too bad my Roomba will no longer be labeled as a person. I'm sure he'll miss that. 🤖