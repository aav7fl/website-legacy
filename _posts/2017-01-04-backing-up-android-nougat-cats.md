---
title: "Backing Up Android Nougat Easter Egg Cats (No Root)"
date: "2017-01-04 5:37"
dateModified: "2017-01-04 5:37"
comments: true
image:
  path: /assets/img/2017/01/banner.jpg
  alt: Android Nougat Easter Egg App
  height: 400
  width: 700
published: true
tag: "small project"
meta: "How to back up and restore your cats from the Google Android Nougat Neko Easter Egg without root using ADB."
---

Every major release of Android in the past couple years has received Google's Easter Egg treatment. They like to sneak in wallpapers, silly animations, or a fun little game. With the release of Android Nougat (7.0.0), the Easter Egg ended up resembling some kind of [Neko Atsume](https://en.wikipedia.org/wiki/Neko_Atsume) themed game.

The concept is quite simple. Once on Android 7.X.X, after [adding the Easter Egg](http://www.howtogeek.com/269207/how-to-enable-android-nougats-cat-collecting-easter-egg/), the player pulls down their notification menu and selects a piece of food to place out. Certain pieces of food net the player a better chance at catching a cat, but these pieces of food respectively take longer before a cat will eat it. After a cat eats the piece of food, the player will be given a chance of catching it depending on what piece of food was placed out. If they succeed the random check, the player will receive a notification and the cat will appear in their inventory. If they fail, the cat will get away with the food and the player will only find an empty bowl with no notification.

![Dark blue cat from Android Nougat Easter Egg](/assets/img/2017/01/bluecat.png)*Jack's Mannequin. Because he's [Dark Blue](https://www.youtube.com/watch?v=P5LjFkibA7w)...*

#### Google Gamifying Notifications

It's silly. It really is. But I like looking at these cats and it's almost like _Google <u>is</u> gamifying the process of me checking my notifications_...and that appears to be happening. They are keeping our vested interest by getting us to return to our notifications with the hope of discovering something new. I like this game..

 I like my little collection of cats so much that I wanted to find a way to back them up. My phone is an LG Nexus 5X. I probably could've stopped at LG and you might have been able to guess what the problem is. My phone is probably doomed.

LG has a [pretty](http://www.techtimes.com/articles/186940/20161125/lg-cant-fix-nexus-5x-bootloop-issue-so-its-offering-full-refunds.htm) [large-scale](http://www.trustedreviews.com/opinions/lg-g4-bootloop-problem-how-to-diagnose-and-fix) [problem](http://www.androidauthority.com/lg-v10-bootloop-problem-711334/) with  [recent phones bootlooping](http://www.androidauthority.com/lg-bootloop-whats-going-on-735474/). When I check out the results of [Nexus 5X Subreddit](https://www.reddit.com/r/nexus5x/), I find horror stories of LG and their support. But I digress. I use the Nexus 5X for the latest Android updates, its cheaper cost, and Project Fi.

Because of the possible impending doom on my Nexus 5X, I wanted to find a way to back it up and keep the cats safe. My requirement, I didn't want to root. A short while ago, I transferred over all of my devices from being rooted and jailbroken to running stock because of how much easier it was to maintain. If I was rooted, I would just turn to Titanium Backup and call it a day. But I couldn't do that. Not without unlocking my bootloader and rooting.

After little bit of research, I found that ADB has this nifty built-in feature that can [backup applications](https://wiki.gentoo.org/wiki/Android/adb) and their data without root.
I threw on USB debugging, connected my phone to the computer, and wrote the following line to back up my Android Nougat Cats with a script.

```ruby
adb backup -f C:\CatsBackup_%date:~-4,4%%date:~-10,2%%date:~-7,2%.ab com.android.egg -system
```

When the command above is run in Windows Command Prompt, a few screens will appear on the phone to confirm the backup and possibly enter a password to encrypt it. ADB will create a small file with today's date on my C: drive named `CatsBackup_20170104.ab` (January 04, 2017) and it will contain the backup data for my cats. If you're not using Windows Command Prompt, go ahead and change the file name to whatever you'd like. I just wanted to make it scriptable for myself.

To restore, simply run:

```ruby
adb restore C:\CatsBackup_20170104.ab
```

I had a few issues at first where it wouldn't restore properly. But after the data was erased for the Easter Egg, I was able to successfully restore one of my backups. That could just be my luck, and others might succeed restoring it over their current cat collection on the first try. But if you're looking to back up your cat collection, this looks like the way to go. You should be able to restore this on any phone (Not sure how it will handle it on a newer version of Android though).

![Dark red cat from Android Nougat Easter Egg](/assets/img/2017/01/velvetcat.png)*Velvet--for obvious reasons*
