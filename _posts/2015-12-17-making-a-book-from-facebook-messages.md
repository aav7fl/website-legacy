---
layout: post
title: Creating a Hardcover Book from a Plethora of Facebook Messages
date: "2015-12-17 18:00"
comments: true
image: 2015/12/banner.jpg
published: false
---

##The Gift of Hardcover
<p class="intro"><span class="dropcap">B</span>ack in October, I wanted to create a meaningful gift for someone very special to me for a special occasion. After brainstorming for a while, I came up with a crazy idea of creating a hardcover book from our earliest conversations on Facebook (I guess I can mark it off as a positive that the information giant held on to this).</p>

The first issue that I needed to address was where I would get a hardcover book printed in a single quantity. I started researching self-publishing services and discovered very quickly that many of them required a minimum quantity before they would accept in order. The ones that did accept a small order had a very high cost for single book. After a bit more searching around I was directed to [lulu.com]( http://www.lulu.com/home). This is where I found the most appropriate pricing for my specific project. I will note however that people may be able to find more appropriate pricing and (especially) more control if they use a local print shop. I started to set up a skeleton for how I was going to build my book.

##Fixing Facebook Messages
Now that I found a service that would print my hardcover book, I had to figure out how I was going to get my archived messages print ready. I knew Facebook had a feature that [allows you to download your entire archive]( https://www.facebook.com/help/212802592074644). This feature presented a zip file that contained a slimmed-down web-version with most of my data. Lucky for me, this included a single HTM file that had all undeleted Facebook messages broken into threads based on users. Unlucky for me, these messages in each thread were all in descending order with the newest messages on top. This would make it very difficult to read in a book if the messages were traveling backwards in time. Making matters worse, each thread containing messages was limited to 20,000. After 20,000 messages, a new thread was created and it had to be located in the file.

With some help from a friend, we created a Python script that parsed through the original messages.htm file and reversed the order of all messages in each given thread. It would then output all of those messages reversed in a simpler HTML file that allowed for easy copy/pasting. I’ve uploaded this project script to GitHub and it can be found here:

###[GitHub: Facebook-Archive-Message-Reverser](https://github.com/aav7fl/Facebook-Archive-Message-Reverser)

The documentation README is on the GitHub page above. These instructions should allow you to repeat the steps that I have in order to create a transcript-like copy of your message archive.

##Formatting the Book
After all my messages were in their correct order, I shifted my focus on how I was going to format this plethora of text into something book-worthy. I downloaded a large hardcover book template from Lulu that matched my desired layout. Then I began my quest of transferring in my Facebook messages. I copied each conversation thread that I wanted from the messages_reversed.html and pasted them into a Word document. Without any formatting, the text was highly unreadable and confusing to which message belonged to which user. I formatted the text to my liking seen below.

<figure>
    <img src='/assets/img/2015/12/layout_before.png' alt='missing' />
    <figcaption>Before formatting</figcaption>
</figure>

<figure>
    <img src='/assets/img/2015/12/layout_after.png' alt='missing' />
    <figcaption>After formatting</figcaption>
</figure>

First, I created a reasonable even spacing between each conversation to make it easier on the eyes (0pt spacing before each paragraph and 6pt spacing after each paragraph). This also condensed the length of my book to something far more reasonable. I set the font to Times New Roman and used size 11.

Next, I used a macro in an answer by the user macropod on [this Microsoft answers post](http://answers.microsoft.com/en-us/office/forum/office_2010-word/a-macro-for-multiple-find-and-replace/822f62cc-ac63-e011-8dfc-68b599b31bf5). This allowed me to replace multiple words in bulk. I used the macro to insert a tab character (\t) between each name and the date timestamp following. Then I set up a right aligned tab stop to force every timestamp on the right-hand side of the page demonstrated in the image above.

![](/assets/img/2015/12/replace.png)

With my last run, I replaced all of the names (in my example post they are “User 1\t” and “User 2\t”) using the built-in replace functions of Word with bolded counterparts to separate themselves from conversations.

The conversations now became readable and I was happy with the result. I had roughly 560 pages of easy to read Facebook messages that were important to both of us.

I cleaned up the rest of my document, added odd/even page numbers, wrote a dedication, created chapters/table of contents, made an introduction, and the list goes on. Once I was satisfied with my formatting and the completion of the other pieces of my book, I exported the book as a PDF (which I’ll also be presenting to her if she wants to attempt to click some of the links inside our messages). After the PDF was uploaded to Lulu I finished up the cover and refined the finishing touches. I completed the project and ordered a proof copy. A short while later it was sitting in my hands. It looked perfect.

![](/assets/img/2015/12/side.jpg)

I was proud and excited for the entire duration of this project. I left some other Easter eggs and other personal touches inside the book that I am sure she will enjoy. This book was made with love.
