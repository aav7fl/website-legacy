---
title: Creating a Hardcover Book from a Plethora of Facebook Messages
date: "2015-12-17 18:00"
comments: true
image:
  url: /assets/img/2015/12/banner.jpg
  height: 814
  width: 1000
published: true
tag: "large project"
meta: "How I made a hardcover book for someone by downloading my Facebook message archive reversing the order of each 20,000 message segment for readability"
---

Back in October, I wanted to create a meaningful gift for someone very special to me for a special occasion. After brainstorming for a while, I came up with a crazy idea of creating a hardcover book from our earliest conversations on Facebook (I guess I can mark it off as a positive that the information giant held on to this).

The first issue that I needed to address was locating a shop to print a single hardcover book. I started researching self-publishing services and discovered quickly that many required a minimum quantity before they would accept orders. The businesses that did accept a small order had a steep cost for single book. I continued researching until I stumbled upon [lulu.com]( http://www.lulu.com/home). This is where I found the most appropriate pricing for my specific project. I will note however that people may be able to find more appropriate pricing and (especially) more control if they use a local print shop. With my printshop selected, I moved sites to tackle my next issue.

## Fixing Facebook Messages

After finding a service that would print my hardcover book, I had to figure out how I was going to get my archived messages "print ready". I recalled Facebook had a feature that [allows you to download your entire archive]( https://www.facebook.com/help/212802592074644). I jumped through the hoops to download my data and was presented a small zip file. This file contained a slimmed-down web-ready version of my Facebook data. Lucky for me, this included a single HTM file that had all undeleted Facebook messages. The structure of the file placed messages inside thread structures. Unlucky for me, these messages inside of each thread were in descending order with the newest messages on top. If I placed the messages in the book like this, it would feel as if the reader was traveling backwards through the story. Making matters worse, each thread was limited to 20,000 messages. After 20,000 messages were written, a new thread was created. The old filled-up threads were then buried by newer threads of conversations above it.

With some help from a friend, we created a Python script that parsed through the original messages.htm file and reversed the order of all messages in each given thread. It would then output all of those messages reversed in a simpler HTML file that allowed for easy copy/pasting. I've uploaded this project script to GitHub and it can be found here:

### [GitHub: Facebook-Archive-Message-Reverser](https://github.com/aav7fl/Facebook-Archive-Message-Reverser)

The documentation README is on the GitHub page above. The README will explain the file structure of the current Facebook archive messages at the time of this post. The instructions should allow you to repeat the steps that I have to create a transcript-like copy of your message archive.

## Formatting the Book

After my messages were in their correct order, I shifted focus on how I was going to format this plethora of text into something book-worthy. I downloaded a large hardcover book template from Lulu that matched my desired layout. Then I began my quest of transferring in my Facebook messages. I copied each conversation thread that I wanted from the messages_reversed.html and pasted them into a Word document. Without any formatting, the text was highly unreadable and confused which messages belonged to which user. I spent some time studying the features and following tutorials for Microsoft Word. I formatted the text to my liking seen below.

![Before formatting](/assets/img/2015/12/layout_before.png)*Before formatting*

![After formatting](/assets/img/2015/12/layout_after.png)*After formatting*

First, I created a reasonable even spacing between each conversation to make it easier on the eyes (0pt spacing before each paragraph and 6pt spacing after each paragraph). This also condensed the length of my book to something far more practical. I set the font to Times New Roman/Size 11.

Next, I used the macro found in an answer by the user macropod on [this Microsoft answers post](http://answers.microsoft.com/en-us/office/forum/office_2010-word/a-macro-for-multiple-find-and-replace/822f62cc-ac63-e011-8dfc-68b599b31bf5). This macro allowed me to replace multiple words in bulk. I used the macro to insert a tab character (\t) between each name and the date timestamp following. Then I set up a right aligned tab stop. This forced every timestamp to align on the right-hand side of the page demonstrated in the image above.

![](/assets/img/2015/12/replace.png)

With my last run, I replaced all of the names (in my example post they are “User 1\t” and “User 2\t”) using the built-in replace functions of Word with bolded counterparts to separate themselves from conversations. All pure cosmetic changes.

The conversations were now readable and I was happy with the result. I had roughly 560 pages of easy to read Facebook messages that were important to both of us.

I cleaned up the rest of my document, added odd/even page numbers, wrote a dedication, created chapters/table of contents, made an introduction, and the list goes on. Once I was satisfied with my formatting and the completion of the other pieces of my book, I exported the book as a [PDF/A](https://en.wikipedia.org/wiki/PDF/A). I will be presenting to her if she wants to attempt to click any hyperlinks inside our messages. I uploaded the PDF/A to Lulu, finished the cover, and refined the last details. I completed the project and ordered a proof copy. A week later it was sitting in my hands. It looked perfect. It was perfect.

![](/assets/img/2015/12/side.jpg)

I was proud and excited for the entire duration of this project. I left some Easter eggs and personal touches inside the book that I am sure she will enjoy. This book was made with love.
