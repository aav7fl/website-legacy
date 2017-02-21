---
title: "Improving Jekyll in 2017"
date: "2017-02-20 2:37"
comments: true
image:
  default:  
    path: /assets/img/2017/02/banner.png
    alt: Travis-CI build log for my Jekyll site
    height: 400
    width: 700
published: true
tag: "large project"
description: "My Jekyll website was in need of an update. I ending up adding tests, continuous integration (Travis-CI), Accelerated Mobile Pages, SEO improvements, and more."
---

When I took a look at my website last year, it needed help. There wasn't a whole lot wrong with it, but there definitely were areas that needed improvement. For starters, I wasn't testing anything (don't judge me). How would I test things? By overkilling the project and setting up [Travis-CI](https://travis-ci.org/) of course.

Next, my website felt a little bulky. My CSS was over-the-top, I didn't need a JavaScript header menu, I had unnecessary nested HTML tags, and still didn't like how some of the elements collapsed on mobile devices.

The last major change that I wanted to implement was **AMP** ([accelerated mobile pages](https://www.ampproject.org/)) to make is easier for mobile devices hitting my blog. This led down a rabbit hole of further changes.

Link to the [website source code](https://github.com/aav7fl/aav7fl.github.io/tree/539c5f439a092fa9d1ad7b335b86a0c07f2955a6) right before this blog post was released.

{% include toc.html %}

## Testing

My website needed testing. I had no excuse. With every new feature added, there was another chance that something would slip and ruin my production release. After adding AMP, I would manually validate each page in Google Chrome using the `#development=1` tag in my URL. For every change the HTML layout, I would miss a close tag. This needed to change.

### HTML Proofer

My first improvement to testing my website was adding [HTMLProofer](https://github.com/gjtorikian/html-proofer). HTMLProofer "is a set of tests to validate your HTML output. These tests check if your image references are legitimate, if they have alt tags, if your internal links are working, and so on. It's intended to be an all-in-one checker for your output."

Cool, right? After I set up the Ruby Gem, I found some broken HTML tags, a few 404 outgoing links, and missing alt tags on images. A few problems solved.

### amphtml-validator

After I implemented AMP (more on that later), I needed a better way to test rather than opening up my browser and validating each page through the dev tools. In steps [amphtml-validator](https://github.com/ampproject/amphtml/tree/master/validator/nodejs); a Node.js package command line tool that validates AMP HTML files.

With a little Ruby-Fu, I was able to add the Node.js package execution to my Rakefile. I find all of the `*.html` files in my AMP directory and pass them one at a time to the amphtml-validator. I check the exit status of the Node.js package, let the user know if it fails, and continue with my day.

```ruby
desc 'Test website AMP validation'
task :amp do
  puts 'Running AMP Validator...'.yellow.bold
  amp_dir = '_site/amp'
  system("find #{amp_dir} -iname *.html | xargs -L1 amphtml-validator")
  if $CHILD_STATUS.exitstatus.zero?
    puts 'AMP Validator finished successfully.'.green
  else
    puts 'AMP Validator FAILED.'.red.bold
    exit($CHILD_STATUS.exitstatus)
  end
end
```

### RuboCop

When I was working on a pull request for another project, the project's Rake tests introduced me to [RuboCop](https://github.com/bbatsov/rubocop). RuboCop is a static code analyzer for Ruby that enforces guidelines from the [Ruby Style Guide](https://github.com/bbatsov/ruby-style-guide). It was a neat little tool that I added to my Rakefile to ensure Ruby code that I wrote would be understood by others. It wasn't a huge change, but it was there to keep myself in check with the community style guidelines (something that I had very little experience with).

## Travis-CI

Adding tests were great. But I also liked the idea that if I was away from my build environment I could make a small change on my phone, test it, and deploy to production. This was a bit of a pipe dream for me. I knew as soon as I added tests, I wouldn't be able to rely completely on GitHub. Likewise, if I wanted to add special plug-ins, say goodbye to GitHub builds.

But [Travis-CI](https://travis-ci.org/) saves the day! Travis-CI will watch for code changes in my repo, fetch it, test it, and if it passes it could be pushed to my GH-Pages branch (where GitHub will deploy online). Pretty cool, huh?

I stumbled across this idea from Savas Labs who wrote a blog post last fall on how they [deploy to GitHub Pages using Travis-CI](http://savaslabs.com/2016/10/25/deploy-jekyll-with-travis.html). They were not the first, but I liked some of the ideas that they used such as bringing in pull requests to the source branch, testing, and deploying to a separate branch for GH-Pages based on test results. I have followed suit. There are just some changes that I made to the scripts, but the idea is still the same.

I'm actually a little proud of this, but my build time is now around 1½ minutes, and deploying only takes another 15 seconds. This was accomplished by:
- Caching Bundler
- Caching Node_Modules
- Resolving [RVM and Node_Modules `which` conflict](https://github.com/travis-ci/travis-ci/issues/5092#issuecomment-245937070). This shaved nearly a minute off the build!

Read more on [Travis-CI caching docs](https://docs.travis-ci.com/user/caching/).

## AMP

Starting back in the middle of 2016, I wanted to implement AMP ([accelerated mobile pages](https://www.ampproject.org/) in my website. In case you didn't know, it's a streamlined version of your webpage strongly optimized for mobile rendering and reduced load times. It also comes with its own special restrictions.

If there was something that would make the web experience faster for any readers, I was interested. My biggest problems were that Jekyll had yet to implement multiple layouts natively. This meant that I needed to rely on an external plug-in in order to generate the AMP pages. Good thing I setup up Travis-CI!

I turned to [amp-jekyll](https://github.com/juusaw/amp-jekyll) (which is now a gem!) to add an AMP layout. There were a few small changes that I needed to make though. I had to figure out how to add videos properly to my posts, remove the AMP pages from my sitemap, and change things like the canonical URL on my AMP pages while using Jekyll-SEO-tag.

### AMP Sitemap Conflict

In order to avoid duplicate results, AMP pages do not need to be added to the sitemap unless they are standalone pages. Referencing them in the `<head>` of the normal page is enough. Because [jekyll-sitemap](https://github.com/jekyll/jekyll-sitemap) knew nothing about my AMP ambitions, I had to manually set a default in my `amp.html` layout frontmatter to stop them from being included.

`_layouts/amp.html`
```html
---
layout: amp
sitemap: false
---
```

### AMP SEO Fixes

Next, my AMP pages had conflicts with the [Jekyll-SEO-Tag](https://github.com/jekyll/jekyll-seo-tag). this was solved by cheating. I call it cheating because it's not a robust solution. If I happen to include the `site.ampdir` anywhere in my SEO tags, it will be removed. So there's always a chance that this could mess up, but I decided that in my personal case, the pros far outweigh the cons.

Whenever I grab the SEO tag, I make sure to run in through my parser first to fix it.

`_includes/amp-check.html`
{% raw %}
```html
{% if include.src == "SEO" %}
  {% if page.url contains site.ampdir %}
    <!-- Assumes AmpDir is never in JSON-LD -->
    {{ seo_text | remove: site.ampdir }}
  {% else %}
    {{ seo_text }}
  {% endif %}
{% endif %}
```
{% endraw %}

Now I simply call the jekyll-seo-tag with `{% raw %}{% include amp-check.html src="SEO" %}{% endraw %}` in the `<head>` of my layout.

### AMP Videos

To implement amp videos correctly, I threw together a small `include` that would take in the parameters from a post specifying the video type and some other special properties.

I would add a video to my post with:

{% raw %}
```html
{% include video.html
  src="/assets/files/2016/03/bug_example.mp4"
  poster="/assets/files/2016/03/bug_example_poster.png"
  controls="loop"
%}
```
{% endraw %}

Here is part of my included video layout that would help insert the video properly for both AMP and default layouts.

`_includes/video.html`
{% raw %}
```html
<!-- Method to implement AMP-Video. -->
{% assign height = include.height | default: "420" %}
{% assign width = include.width | default: "700" %}
{% assign type = include.type | default: "normal" %}

{% if type contains 'normal' %}
  {% if page.url contains site.ampdir %}
    <amp-video height="{{ height }}" width="{{ width }}" poster="{{ include.poster }}" layout="responsive" controls {{ include.controls }}>
      <div fallback>
        Your browser doesn’t support HTML5 video
      </div>
      <source type="video/mp4" src="{{ include.src }}"/>
    </amp-video>
  {% else %}
    <video width="{{ width }}" controls {{ include.controls }}>
      <source src="{{ include.src }}" type="video/mp4" />
      <p>Your browser doesn’t support HTML5 video</p>
    </video>
  {% endif %}
{% endif %}
```
{% endraw %}

# EXPLAIN HERE

> You can find more information or any updates to my implementation on the [repo Wiki](https://github.com/aav7fl/aav7fl.github.io/wiki).

### Results

Now when I run the `amphtml-validator` tests, all of my AMP pages pass.

```shell
Running AMP Validator...
_site/amp/blog/2013/04/somewhere-to-start/index.html: PASS
_site/amp/blog/2013/09/restoring-vintage-with-3d-printing/index.html: PASS
...
_site/amp/blog/2016/07/fixing-no-google-profile-for-contact/index.html: PASS
_site/amp/blog/2017/01/backing-up-android-nougat-cats/index.html: PASS
AMP Validator finished successfully.
```

An explanation on my testing method is explained earlier in this post.

## Other Improvements

Outside of testing/building, there were a few other improvements that I made to my website. I fixed conflicts with AMP pages and other plugins, added a wiki to the website repo, and put forth a small graphical upgrade with favicon branding and banners.

### Plugins

Earlier in this post I talked about how I was using Travis-CI to build and deploy my website. Now that I was building outside of GitHub, I could use my own plugins. One of them I've already mentioned; amp-jekyll. This was used to implement an AMP layout to my blogs postings.

The only custom plugin that I am using is jekyll-seo-tag. Or... a fork of jekyll-seo-tag. That is, until they hopefully accept my [pull request](https://github.com/jekyll/jekyll-seo-tag/pull/151). My pull request corrects and updates the JSON-LD for a blog post to meet Google's current standards. But for now, I have a special entry in my gemfile pointing to my fork.

`Gemfile`
```ruby
group :jekyll_plugins do
  git 'https://github.com/aav7fl/jekyll-seo-tag.git' do
    gem 'jekyll-seo-tag', branch: 'testing'
  end
end
```

### Website Wiki

I have also added a [wiki to my website repo](https://github.com/aav7fl/aav7fl.github.io/wiki). I did this because the `README.md` for my repo was becoming far too large to include all of the information about how to build, customize, and deploy my website. This also meant that I could make separate changes to the documentation without adding another code commit.

### Less Code is More

Lastly, I made a substantial improvements to the CSS, lightened the webpage layout, and squashed remaining bugs that I could find (Looking at you MS Edge...). Below is a complete list of the major changes I made. They don't deserve their individual own section, but they are still worth mentioning

- Removed CSS normalize/Strongly simplified
- Removed complicated JavaScript header navigation (CSS3 only now)
- Switched post-navigation and footer to use Flexbox that collapses responsively
- Switched to HTML5 tags (main, article, footer)
- Fixed SVG banner image bugs that existed in Edge/IE and iOS Safari
- Added favicon sets using [RealFaviconGenerator](https://realfavicongenerator.net/) with updated colors
