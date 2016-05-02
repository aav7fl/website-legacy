---
layout: post
title: iOS Video Player Bug Disclosure
author: Kyle Niewiada
date: '2016-03-20 18:05'
comments: true
image: /2016/03/iPadTesting.jpg
published: true
tag: "large project"
meta: "A public disclosure that I discovered of an iOS video playback bug that decreases red and becomes washed out when user interface elements are hidden"
---

There exists a bug with the iOS video playback and color reproduction. When specific combinations and proportions of colors are present on screen, if (and only if) all user interface elements are hidden, then a decrease in color temperature (mostly red) occurs. This seemingly subtle shift in color turns cartoon characters and online content creators into ghostly pale figures.

![comparing video playback demonstrating bug with and without user interface](/assets/img/2016/03/comparison.jpg)*Note the subtle differences in facial tones and woodgrain color*

<video width="800" controls loop>
  <source src="/assets/files/2016/03/bug_example.mp4" type="video/mp4" />
  Your browser does not support the video tag.
</video>

## Steps to Reproduce:

1. Turn off auto brightness under iOS settings (just in case it may influence the results).
2. Open Safari on your iOS device and navigate to this page.
3. Play the video above in full-screen mode (landscape works best).
4. Tap to hide any user interface elements (such as the AssistiveTouch button or  playback buttons).
5. Once the user interface is hidden, the face of the character in the middle of the screen will transition for a few seconds to a whitish-green.
6. Tapping the screen to bring back the user interface will cause the face to regain its proper coloring.

### Reproducible (so far) on:

- iPhone 6 (iOS 9.2.1)
- iPad 4 (iOS 9.2.1)
- iPad Air 2 (iOS 9.0.2)
- iPad Pro (iOS 9.2.1)

## Proof through Testing

When I first stumbled across this bug, I thought there was a problem with my iPad Air 2. It was not until I tested this scenario on multiple iOS devices before I was convinced that it was a bug with either iOS or all recent hardware iterations. However, I wanted to be able to prove that this bug existed and that my eyes were not playing tricks.

I dug out my colorimeter ([i1Display Pro](http://www.xrite.com/i1display-pro)) that I use to calibrate my monitors in hopes that it would be useful for my project. I tried to use the software that came with it, but nowhere could I find any options to let me read and collect the color value data points.

After searching for software solutions that would allow me to read color data points from my colorimeter, I stumbled across HCFR. [HCFR](https://sourceforge.net/projects/hcfr/) is an open source calibration tool that allowed me to read the color percentages and values (among many other things) through my colorimeter; then graph and observe these data points.

## Capturing Results

![Capturing iPad Air 2 results](/assets/img/2016/03/iPadTesting2.jpg)*Capturing iPad Air 2 results*

I used the bug reproduction video above for my sample capture data on my iPad Air 2. Below is a video demonstrating the live capture with my colorimeter as I replicate the bug behavior --hiding and restoring the user interface.

<video width="800" controls autoplay loop>
  <source src="/assets/files/2016/03/graphs.mp4" type="video/mp4" />
  Your browser does not support the video tag.
</video>

![HCFR Capture Window](/assets/img/2016/03/capture_small.jpg)*[HCFR Capture Window (click to view larger image)](/assets/img/2016/03/capture_large.jpg)*

\[[HCFR Capture Results File](/assets/files/2016/03/ColorMeasures1.chc)]

## Notes

### Disclosure
December 13, 2015 I submitted this to [Apple's bug reporter]( https://bugreport.apple.com/). February 16, 2016 Apple Developer Relations responded that this was a limitation of the hardware and could not be fixed without a significant impact to power. They state plans to address this issue in the next hardware architecture.

### Reproducibility

Only under certain conditions with specific color palettes am I able to reproduce this bug. This happens very infrequently. The majority of the time this change in color temperature will not occur. But when it does, it becomes painfully obvious. I have been able to reproduce this with a higher success rate when viewing cartoons because of their stable color palette of the scene. The most notable example I have come across is the TV show, [Archer](https://en.wikipedia.org/wiki/Archer_(TV_series)) where it occurred many times throughout the first six seasons.

#### Non-Cartoon Example

An example of this bug occurring on a human face is in [this YouTube video]( https://youtu.be/utWQW_TF4ZY?t=535
) of jacksepticeye. Around the 8:55 mark, the game in the background consists of predominantly gray colors. During this time, when the user interface for YouTube is hidden on the iOS device, the flesh tones on Sean's face in the corner will transition into a harsh white.

## "Solutions"

Across the web [\[1\]](https://www.reddit.com/r/ipad/comments/2w84cw/) [\[2\]](https://discussions.apple.com/thread/4581841) [\[3\]]( https://discussions.apple.com/thread/3822777), there exist somewhat related bugs with iOS video playback and reproduction. Although I can't say that these issues are directly related, the solution for most of these is to turn on AssistiveTouch.

`General>Accessibility>AssistiveTouch>On`

AssistiveTouch (among other things) places a virtual shortcuts/home button on top of every screen on your device. When this occurs, the iOS device considers this a piece of the user interface (why shouldn't it be?). Because of this behavior, when trying to replicate the bug behavior with the video player, it will not occur because the AssistiveTouch is visible on screen.

I found it a little strange that the AssistiveTouch solution for other brightness issues on the iPad worked for the color changes during video playback.

## Why Does This Bug Happen?

I don't know. I have been trying to figure this out for months. I had hopes that submitting the bug report would give me more answers. I simply do not understand  the *exact* conditions that produce this bug. I tried reproducing the bug with an image containing the top eight prominent colors in the bug example video. It did not work.

Here are the best (abeit far-fetched) theories that I can come up with as to why the (1) color shifts (2) with certain color palettes (3) during videos with a hidden user interface.

### Theories
- It *really* is a hardware bug that Apple can't fix without sacrificing power saving features baked into the operating system.
- Maybe it's possible that iOS is detecting low color on the screen and is assuming that the content is nonmedia (i.e. books/text). It is reducing color gamut to somehow save power with the GPU (if that's even possible) or something similar.
- Perhaps the shift in the red channel has something to do with early preparations for the upcoming [Night Shift](http://www.macrumors.com/how-to/use-ios-9-3-night-shift-mode/) feature.
- It's a software bug that they are unable to fix without changing too much of iOS.
- Maybe a recent change in iOS video players is a contributing factor

## Conclusion

Without knowing more about iOS inner workings, it's hard to say how much of the operating system this bug affects. But for now, it remains a mystery to myself.

I wanted to publicly disclose this bug because I understand how frustrating it can be to research such a subtle bug and come up empty while trying to reproduce it. I am hoping that this post will help other users that search for the problem demonstrated be aware that it exists, can be reproduced, and let them know what I have discovered.
