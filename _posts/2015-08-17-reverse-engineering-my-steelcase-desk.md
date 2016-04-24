---
layout: post
title: Discovering and Reverse Engineering My Steelcase Desk
author: Kyle Niewiada
date: "2015-08-17 15:47"
comments: true
image: 2015/08/banner.jpg
published: true
tag: "medium project"
meta: "reverse engineering the remote codes on my Steelcase sit stand desk prototype"
---

In 2013 I made the plunge for a height-adjustable standing desk. I had wanted one for a while because I was becoming restless sitting down throughout the day in my computer chair. I wanted to be able to move around easily while I was using it and not be chained to sitting. I won't go into the health benefits or drawbacks of such a setup, but instead how I discovered and reprogrammed my desk.

Lucky for me, during my search for an adjustable standing desk, Steelcase was liquidating their old pyramid headquarters/test labs. You can get a pretty good look at how amazing the building and the labs were in a tour of the campus [here](https://www.youtube.com/watch?v=GTsdOLD-CyI).
I contacted up the warehouse that was selling off Steelcase's office furniture and drove on over.

In my head, my ideal desk would be one that would (1) raise and lower, (2) use no electrics, (3) be reasonably priced for such a feature list, and (4) have a short enough width to fit in my room. I had arrived at the warehouse and to my dismay learned that someone had purchased all 40 Airtouch Steelcase desks the night before (a desk that can be raised and lowered with a hydraulic not using any electricity). I had done research and found that this was the only currently available height adjustable desk that would have fit in my room.

Not being deterred, I began to browse the electric section of the height-adjustable desks in the warehouse. I thought maybe I could replan my room again. That's when I stumbled upon a very peculiar looking desk. This desk did not show up in any standard Steelcase lineup. I pulled out my ruler and took some measurements to find that it would fit perfectly. I haggled a bit on the price, bundled in two monitor arms, and bought it.

<figure>
    <img src='/assets/img/2015/08/desk.jpg' alt='My new desk' />
    <figcaption>My new desk</figcaption>
</figure>

### What _Exactly_ did I Buy?

It wasn't until I had the desk back at home that I realized I could find no listing of this unit in any Steelcase catalogs (maybe I wasn't looking hard enough?). I got in contact with Steelcase and Andrea from the Steelcase store was able to provide:

"J797763SR. It looks like it's for the Worksurface-Elec, straight, 48, Radius, brand:steel, product line:pathways secant"

I also had discovered that what I had in my hands was a **test sample**. On the back of the unit was slapped a sticker that was partially pulled off. It stated that it was from the product development labs, had a fill out date of May 7, 2003, the request number, the person who requested, the specialist, the description for the unit, and the sample ID.

![](/assets/img/2015/08/test_sticker.jpg)
![](/assets/img/2015/08/order_sticker.jpg)

This might have explained why I had such an odd remote to it. I'm not sure what the lineup was like back in 2003 for Steelcase height-adjustable electric desks. I was unable to find desks that used the same remote as mine, or even a similar configuration. Given that I had a test unit, I began to wonder if there were special testing properties to the remote.

### Solving a Problem

I was always annoyed with the remote on my desk because I had to hold down the programmed buttons to allow it to raise or lower. I understand that this is a safety feature to prevent children from being crushed or items being lifted off of the desk. But I was never a fan of being forced to hold down the buttons. As I'm always standing by (/badJoke) when I raise or lower it, I wanted to find a way to make this unit adjustable with a single momentary button press.

There was no documentation on my desk and I knew nearly nothing about the remote other than its more recent incarnations with a similar button layout on newer desks. I began to play with it and see if there were any hidden modes or features I was unaware of.

After a lot of trial and error, and mapping out possible and probable key combination sets, I discovered two different programming modes for my desk remote. One was temporary and the other was permanent until exited. Below are my findings (**including a way to change the adjustment mode from manual to automatic!!**).


### Remote Modes:

Passcode Mode (P-Mode): P---

  - Permanent P-Mode (Or until remote reboot): Goto PArA, Press Down 3X, Press 1 9X
  - Temporary P-Mode: Goto PArA, Press III 3X, Wait 3 seconds.

PArA Mode: PArA

  - To reach PArA menu, press F until display reads PArA.
  - If in Passcode Mode, unplug desk, plug back in.

  <figure>
      <img src='/assets/img/2015/08/normal.jpg' alt='Normal mode' />
      <figcaption>Normal mode</figcaption>
  </figure>
  <figure>
      <img src='/assets/img/2015/08/PArA.jpg' alt='PArA mode' />
      <figcaption>PArA mode</figcaption>
  </figure>
  <figure>
      <img src='/assets/img/2015/08/passcode.jpg' alt='Passcode mode' />
      <figcaption>Passcode mode</figcaption>
  </figure>



<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;border-color:#ccc;}
.tg td{font-family:Arial, sans-serif;font-size:14px;padding:2px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#ccc;color:#333;background-color:#fff;}
.tg th{font-family:Arial, sans-serif;font-size:14px;font-weight:normal;padding:2px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;border-color:#ccc;color:#333;background-color:#f0f0f0;}
.tg .tg-e3zv{font-weight:bold}
@media screen and (max-width: 767px) {.tg {width: auto !important;}.tg col {width: auto !important;}.tg-wrap {overflow-x: auto;-webkit-overflow-scrolling: touch;}}</style>
<div class="tg-wrap"><table class="tg">
  <tr>
    <th class="tg-e3zv">Code:</th>
    <th class="tg-e3zv">P-Mode:</th>
    <th class="tg-e3zv">PArA Mode:</th>
    <th class="tg-e3zv">Default Value (As I found it)</th>
  </tr>
  <tr>
    <td class="tg-e3zv">111</td>
    <td class="tg-031e">Set offset curve multiplier (from min)</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e">1970</td>
  </tr>
  <tr>
    <td class="tg-e3zv">112</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-e3zv">113</td>
    <td class="tg-031e">Hand/Auto toggle (Auto travel to programmed position)</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e">Hand (But I like Auto)</td>
  </tr>
  <tr>
    <td class="tg-e3zv">121</td>
    <td class="tg-031e">Acc.# (0-9) Distance to start decelerating from below a number?</td>
    <td class="tg-031e">Acc.# (0-9) Distance to start decelerating from below a number?</td>
    <td class="tg-031e">4</td>
  </tr>
  <tr>
    <td class="tg-e3zv">122</td>
    <td class="tg-031e">Acc.# (0-9) Distance to start decelerating from above a number?</td>
    <td class="tg-031e">Acc.# (0-9) Distance to start decelerating from above a number?</td>
    <td class="tg-031e">4</td>
  </tr>
  <tr>
    <td class="tg-e3zv">123</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-e3zv">131</td>
    <td class="tg-031e">Upward Speed (1-39)</td>
    <td class="tg-031e">Upward Speed (1-39)</td>
    <td class="tg-031e">39</td>
  </tr>
  <tr>
    <td class="tg-e3zv">132</td>
    <td class="tg-031e">Downward Speed (1-39)</td>
    <td class="tg-031e">Downward Speed (1-39)</td>
    <td class="tg-031e">39</td>
  </tr>
  <tr>
    <td class="tg-e3zv">133</td>
    <td class="tg-031e">Height offset for minimum height</td>
    <td class="tg-031e">Height offset for minimum height</td>
    <td class="tg-031e">23(.)3(")</td>
  </tr>
  <tr>
    <td class="tg-e3zv">211</td>
    <td class="tg-031e">LErN (Calibrates based on min (133) and max offset (111))</td>
    <td class="tg-031e">LErN (Calibrates based on min (133) and max offset (111))</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-e3zv">212</td>
    <td class="tg-031e">UrLA (Calibrates based on software defaults?  24¼" to 52")</td>
    <td class="tg-031e">UrLA (Calibrates based on software defaults?  24¼" to 52")</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-e3zv">213</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-e3zv">221</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-e3zv">222</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-e3zv">223</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-e3zv">231</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-e3zv">232</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-e3zv">233</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-e3zv">311</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-e3zv">312</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-e3zv">313</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-e3zv">321</td>
    <td class="tg-031e">Toggle USA/Eur units (for height)</td>
    <td class="tg-031e">Toggle USA/Eur units (for height)</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-e3zv">322</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-e3zv">323</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-e3zv">331</td>
    <td class="tg-031e">Max weight setting? Current weight setting? (0-140)</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e">70</td>
  </tr>
  <tr>
    <td class="tg-e3zv">332</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e">X</td>
    <td class="tg-031e"></td>
  </tr>
  <tr>
    <td class="tg-e3zv">333</td>
    <td class="tg-031e">SPP- (Set Program Position?) Manually set program # height</td>
    <td class="tg-031e">SPP- (Set Program Position?) Manually set program # height</td>
    <td class="tg-031e"></td>
  </tr>
</table></div>

#### To calibrate desk remote display:

<ol>
<li>Turn on desk.</li>
<li>Lower desk to minimum height.</li>
<li>Measure distance from the floor to the top of the desk.</li>
<li>Enter code 133 in either P-Code or PArA mode.</li>
<li>Change number to reflect the minimum desk height (Inches or cm pending the setup for units).</li>
<li>Press F</li>
<li>Raise desk to maximum height. The display will likely jump when the max height is reached.</li>
<li>Measure distance from the floor to the top of the desk.</li>
<li>Enter Passcode Mode (See top).</li>
<li>Enter code 111.</li>
<li>Raise or lower number the number to correct your max height. The number behaves like X, where X is the number you are adjusting. My calculations and formula were based on inches. Your results might vary.</li>
</ol>
```
MaxHeight - MinHeight - 11.8
---------------------------- + 1500 = X
		.0079059829

In my case, I would have

38.8 - 23.3 - 11.8
------------------ + 1500 = 1968
   .0079059829
```

<ol start="12">
<li>After adjusting, back out and check your latest displayed height. If the height displayed is correct, move on. If not, re-adjust step 11 again.</li>
<li>Lower desk height half-way.</li>
<li>Enter code 211 in either P-Code or PArA mode.</li>
<li>Press F until “Init” is displayed.</li>
<li>The motor will now respond slowly until calibration is completed.</li>
<li>Lower desk to its minimum height.</li>
<li>Raise the desk to its maximum height.</li>
<li>When you reach the top, the display will change to the correct height and the calibration of the desk will be complete.</li>
</ol>

### Conclusion

I like switching between sitting and standing when I'm at my computer. Whenever I hook up my controller and play a game, I prefer standing because I get very involved and move around. My monitors easily change position so I can readjust my workstation on the fly. It's hassle-free. I'm glad I was able to discover the settings that could change the adjustment mode to automatic. Now that I've had experience with the setup, I don't think I'll ever be going back to full-time sitting.

Don't knock it until you try it.
