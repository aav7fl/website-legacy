---
layout: post
title: "Microsoft Word Auto-Journal Macro for the Lazy"
author: Kyle Niewiada
date: "2016-03-14 16:19"
comments: true
image: /2016/03/banner.png
published: true
tag: "small project"
meta: "I created a Microsoft Word macro that automatically generated a skeleton entry for today and added up the total hours documented thus far"
---

A few months back I was given the requirement for a project to keep some kind of journal logging the number of hours I spent on a task along with a short description. Because the project was deeply integrated with Microsoft products and services, I decided that it would be best to write such a journal with Microsoft Word.

As is the motivation for many projects/scripts of mine, I wanted to automate the process as much as possible such that I never had to think about it again [anytime soon]. This was shortly after I had [concluded work on a previous project](/blog/2015/12/making-a-book-from-facebook-messages/) that involved using Microsoft Word with macro scripts. I was ready to learn more about its advanced features. I wanted an automatic running total because I would often forget to recalculate my grand total after each entry. There were probably other solutions that were better suited for this, but I really wanted to see how useful Microsoft Word macros (I know the evil stigma associated with macros) could be to me.

#### Goals:

1. Automatically insert a new blank entry for today with the cursor ready to write a description
2. The ability to total hours for all entries without the user remembering
3. Automatically update total hours at top of document

#### Results:

I created a Microsoft Word macro enabled document that when opened will:

1. Automatically remove empty paragraphs that Microsoft Word *loves* to place at the end of your document
2. Add skeleton text containing today’s date, start, end, and total time
3. Add a paragraph labeled "Description:"
4. Calculate total hours on exit without user needing to remember
5. Automatically add skeleton entry on document open

### What it does

I have provided an example document below. It includes a text-button to add the total number of hours for each entry and another text-button to add new journal entries.

The macro calculates the total number of hours entered by searching for the 'Total [\*]' string. When it matches, it will add the number found between '[]' to a running total until the entire document has been searched. It will then return the total. The example document shows this total at the top. It is not foolproof. It can be easily defeated if someone decides to include the 'Total [\*]' string inside their journal entry, or if one wants to overflow the numbers. But it works for me without any major issues (including the null value case), and that is what mattered.

The macro adds a new journal entry to the end of the text by searching for the end of the document, removing any extra paragraphs at the end of the document, and then adding in the pre-scripted skeleton structure for a new journal entry with the date of today. During planning, I could have gone above and beyond and calculated the total hours between the start time and end time of a task/added it to the 'Total []' field, but I decided to draw the line there. The amount of work I was putting in for something that would take no time to accomplish would not be paying off.

When the document is closed, the macro will run and add up the total number of hours from the listed entries automatically. A save dialog will then pop up and the user may choose to save or discard changes.

### Source code and example document

[Microsoft Word Auto-Journal example document](/assets/files/2016/03/JournalExample.docm)

Above is a link to the macro enabled Microsoft Word document example. Below is the source code for the macro. Most of it is pieced together from other examples online accomplishing similar tasks. I spent most of my time looking at different resources for visual basic techniques and have mentioned those sources in nearby comments for pieces of code where available.

<script src="https://gist.github.com/aav7fl/7df0051c6fa9fd8a42bb.js"></script>
