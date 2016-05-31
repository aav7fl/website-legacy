---
layout: "post"
title: "Streaming Desktop for a Virtual Reality Spectator View using my Raspberry Pi 2"
author: "Kyle Niewiada"
date: "2016-05-21 14:45"
comments: true
image: /2016/05/banner2.jpg
published: true
tag: "medium project"
meta: "How I used my Raspberry Pi 2 to stream my desktop using Moonlight Embedded for my HTC Vive virtual reality spectator view without interfering with SteamVR."
---

I think virtual reality is a lot of fun. I had a friend in college demo an Oculus DK1 to me and I was pretty amazed; even though I was running it on a laptop, and the display drivers turned everything into wireframe models. I remember getting my hands on my first Google Cardboard, sliding my phone in, and exploring the world through Google Earth. When the HTC Vive went on sale, I bought it. My first real chance to become heavily immersed in a new world.

My HTC Vive setup didn't fit in my room, so I ran some cables to put it in the room next door. But now, no one else in the VR room could see what I was doing. There was a problem; I wanted to let those around me see what I was seeing. I had to figure out a way to mirror or broadcast my desktop to the other room.

My first thought was that I was going to use my Steam Link as a way to rebroadcast desktop. Just like how they advertise it for streaming games. I thought this was going to work because it had the feature to minimize the Steam Big Picture application and use the desktop instead. But as I began to find out, this did not work with all Steam VR applications and the usability of the HTC Vive suffered. If I launched games from my steam link, I could no longer use the VR menu. If I tried to launch the Steam Link after I was in the VR menu, it would refuse because I was already "in game". I tried using Splashtop (Remote software) to stream it to my device, but it was unable to draw the desktop unless I forced it --this interfered with my Vive yet again.

After failing to use the Steam Link and Splashtop, I came across others mentioning Nvidia's GameStream as an alternative. Nvidia has a built-in feature with their newer graphics cards that allow one to stream their gaming set up to an Nvidia Shield tablet. Luckily, there was an open source client alternative, [Moonlight Embedded](https://github.com/irtimmer/moonlight-embedded). Sure, I could have probably set up a VNC server/VNC client but who knows how long it would've taken for me to get optimized for streaming games, and where was the fun in that?

It was settled. I was going to install Moonlight Embedded to my Raspberry Pi 2. Here is what my setup is so far.

## Hardware I used:

- Raspberry Pi 2 running Raspbian Jessie (May 2016) using NOOBS
  - Including peripherals such as micoSD card, HDMI cable, case, USB micro power adapter.
- Computer with Windows 10
- Nvidia GTX 970 graphics card
- [Moonlight Embedded](https://github.com/irtimmer/moonlight-embedded)

## Setting Up the Pi

The first thing that I did was install the latest Raspbian Jessie release on my Raspberry Pi 2 [using NOOBS](https://www.raspberrypi.org/downloads/noobs/). I originally was using the TP-LINK TL-WDN3200 wireless adapter with my Raspberry Pi to connect on the 5 GHz network. But as I found out later, this was a problematic adapter. After my installation was finished, I followed the Moonlight Embedded directions found in the [documentation](https://github.com/irtimmer/moonlight-embedded/wiki/Packages)

Adding the line:

` deb http://archive.itimmer.nl/raspbian/moonlight jessie main `

to this file:

` /etc/apt/sources.list `


And running the following to now install Moonlight Embedded.

```
apt-get update
apt-get install moonlight-embedded
```

Once everything was complete, Moonlight Embedded was installed and ready to use.

## Setting Up the Computer

I switched over to my desktop, opening up Nvidia GeForce Experience, and added the information below as a custom Shield game. The application below is Windows built-in remote desktop software. I was going to use it to access my machine in the other room remotely.

![Adding remote desktop as Nvidia GameStream custom game](/assets/img/2016/05/GFEWindow.png)*Adding remote desktop as Nvidia GameStream custom game*

```
Name: RemoteDesktop
Target: "C:\Windows\System32\mstsc.exe"
Start in: C:\Windows\System32
```

## Finising the Pi

### Pairing the Pi

To initiate pairing:

```
moonlight pair 192.168.1.X (replace with your PC's IP)
```

Type in the pairing code presented into your desktop window, and then you should be successfully paired.

I created a handy streaming script for my own needs to start streaming on the Raspberry Pi. Make sure to give it execute permissions to be able to run it.

Check out the rest of the [documentation arguments](https://github.com/irtimmer/moonlight-embedded/tree/master/docs). Your settings will probably differ.

```
#!/bin/bash

#Disable screen saver blanking.
xset s off

#Disable Energy Star features.
xset -dpms

#Start the Moonlight stream. Make sure to replace the remote address with your own computer's IP
moonlight stream -720 -60fps -bitrate 10000 -localaudio -app RemoteDesktop 192.168.1.X

#Enable screen saver blanking
xset s off

#Turn off power saving screen features.
xset s on

#Enable Energy Star features.
xset +dpms
```

*Don't forget! Ctrl+Alt+Shift+Q quits the streaming session.*

## Problems I Had and Explanations

My installation wasn't very smooth. I had a lot of problems along the way that kept setting me back and extended the project duration for a couple days.

### My Raspberry Pi was extremely slow at downloading.

It was not receiving enough power so I do use a different USB adapter to give it more. I didn't realize that's what the flashing logo on the top right corner meant. But once I did figure it out, my download speeds over my network soared past the 1 Mbit that I was getting before.

### Audio would not stream

My audio wouldn't stream at first to my Raspberry Pi because I wasn't using the `-localaudio` flag. This meant that the primary sound device was changing, then SteamVR was also attempting to change the primary audio device to the HTC Vive, and they were both conflicting with each other. If I did manage to have it to stream to the special Nvidia audio driver, I found it to stutter quite a bit. So I resolved this issue by using the local audio flag to prevent my sound device from changing.

### Wireless streaming stuttered every 60 seconds for 10 seconds.

My wireless adapter was the primary culprit to this. There was some issue with it either being powered or sharing band with on the USB bus with my Raspberry Pi. I switched to my handy [IOGear Ethernet/Wireless adapter](http://www.amazon.com/IOGEAR-Universal-Ethernet-Adapter-GWU627/dp/B004UAKCS6) and have had little problems streaming 20 Mbit streams. This adapter might not work for everybody. It uses the 2.4 GHz band which is commonly known to be quite crowded. My Raspberry Pi is near the wireless access point, so it has little interference.

### My HDMI monitor would not turn off after screen blanking with the Pi

I added the undocumented/unsupported `hdmi_blanking 1` to the bottom of my `/boot/config.txt` file and rebooted. This allowed my monitor to enter standby mode when the Raspberry Pi screen blanked.

### If my monitor turned off in a remote session, I could not turn it back on without killing the session.

My solution to this was just a bit more of a lazy hack. I decided to create a script (listed above) that turns off the power saving features before I enter streaming modesave file and restore them after ending the stream. This ensures that I will not get stuck with a monitor in standby while streaming.
