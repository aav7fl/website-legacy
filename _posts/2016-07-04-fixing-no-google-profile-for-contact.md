---
title: "Fixing 'No Google Profile for Contact'"
date: "2016-07-04 11:26"
comments: true
image:
  default:  
    path: /assets/img/2016/07/banner2.jpg
    alt: No Account for Google Profile on Android Wear Watch
    height: 450
    width: 800
published: true
tag: "small project"
description: "How I fixed the Google now 'No Google profile for Contact' message with my account. This occurred because of conflicting Google+ profiles."
---

If you’re around me enough, you learn that I love to use voice commands. I’ve been known to walk into a room and shout “okay Google” hoping to hear a device accepting my query. Since early 2015, people have been able to use Google Now to send Hangouts messages. I tried jumping on that bandwagon but every time I attempted to send a message, I was greeted with the response `No Google profile for <Contact>`.

![No Google profile for contact found](/assets/img/2016/07/noaccountphone.png)*No Google profile found on my phone*

It worked fine if I was sending an SMS, but never with a Hangouts message. There are a [few](https://productforums.google.com/forum/#!topic/hangouts/8Qm5O5ekTG4) [examples](https://productforums.google.com/forum/#!topic/hangouts/spcmG8qtgiA) of others finding their own solution or having a server-side fix rolled out. But this was not the solution for me. I tried everything from factory resetting my phone, sideloading the Google contacts app, even loading an Android ROM on a backup phone and retrying the voice commands. But nothing worked.

## First There Were Three

It wasn’t until a few months ago that I realized I had somehow acquired _three Google+ profiles_ tied to my email. This was a little strange.

1. My first Google+ account was set up and tied to my primary account.
2. My second Google+ account was created as a separate profile for my YouTube account [described here](https://support.google.com/youtube/answer/2663685).
3. When I was managing my accounts I noticed that I had a third one. It appeared that Google had made a Google+ [business page](https://business.google.com/create) for my YouTube’s Google+ account. Or maybe I did this by mistake, but I don’t recall going through the creation process.

Now I had three Google+ accounts tied to my primary email. When I tried to speak a Google Now Hangouts command, it would not find any contacts. Honestly, I can’t remember if it ever worked before then.

I had a theory. I thought that there might be a conflict in which route my Google Now commands were following to gather my contacts. The first thing I did was [delete my Google+ business page](https://support.google.com/plus/answer/1044503) because it wasn’t linked to anything. Next, I tried to delete my Google+ page linked to my YouTube channel. However, because it was linked, I could not delete it. [This setting](https://www.youtube.com/account_transfer_channel) allowed me to switch my connected Google+ profile on my YouTube channel. After severing the link, I was then able to close my old YouTube’s Google+ account.

## Then There Was One

Now I was down to a single Google+ profile. I tried ringing off my voice command “okay Google, send a hangouts message to &lt;Contact&gt;”… And it worked! Unlinking and removing the excess Google+ profiles fixed the path for Google Now finding my contacts. It appears as if there was a conflict between which Google+ account the commands were using.

If you’re scouring the Internet ripping your hair out like I was trying to find a solution for the 'No Google profile for &lt;Contact&gt;' message, check to see if you have any excess Google+ profiles tied to your account. Remove/unlink them if you can, and maybe it will fix your problem like it did mine.
