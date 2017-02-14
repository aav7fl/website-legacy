# My personal website [![Build Status](https://travis-ci.org/aav7fl/aav7fl.github.io.svg?branch=source)](https://travis-ci.org/aav7fl/aav7fl.github.io)

This is my personal website where I write about projects I have worked on.

This site is built using Jekyll, Travis-CI, and Gulp (for local development only).

https://www.kyleniewiada.org/

`source` branch contains the website source code.

`master` branch contains the generated website.

## Installation

These following steps *should* work to setup. But I might have missed something..

From the root directory of the repository:

1. Install RVM stable with ruby (Reboot may be necessary after):

  `\curl -sSL https://get.rvm.io | bash -s stable --ruby`

2. Install Bundler

  `gem install bundler`

3. Install Ruby Gem Dependency Files

  `bundle install`

4. Install Node.js (with NPM)

  `https://nodejs.org/en/download/package-manager/`

  In my case for Linux Mint
  ```
  curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
  sudo apt-get install -y nodejs
  ```

5. Update NPM

  `sudo npm install -g npm`

5. NPM Dependencies

  `npm install --no-optional`

6. Launch Jekyll Server/Browser-Sync/Website

  `gulp`

If you need to update any NPM dependencies ([source](http://stackoverflow.com/a/22849716/1813592)):
```
npm i -g npm-check-updates
npm-check-updates -u
npm install
```

## Local development

Launch Dev environment (Jekyll Server/Browser-Sync/Website) with `gulp`. Right now, `Gulp` is really only used for BrowserSync on the local development. It isn't used for the final build until I see a better reason to use it.

### BrowserSync

This site uses [BrowserSync](https://browsersync.io/) for developing.

- It keeps the browsers in sync so I can code in my VM and sync across to my physical machine/mobile devices for the results.
- It syncs any changes immediately (usually..) to all devices and refreshes the webpage when a change is detected.

## How to use things

### Writing a post

Each post should be located in the `_posts` directory and follow the [proper Jekyll naming convention](https://jekyllrb.com/docs/posts/#creating-post-files).

The post Front Matter should contain the following for all dependencies:

```
---
title: "PostTitle"
date: "2017-01-04 5:37"
dateModified: # "Will default to `date` if not specified"
comments: true # Turn off or off comments for post
image:
  url: /assets/img/2017/01/banner.jpg
  alt: Image Alt Text
  height: 400
  width: 700
published: true # Whether to publish or not
tag: "small project" # Tag used for Post Collating
meta: "Meta text used for SEO/JSON-LD"
---
```

### Travis-CI

[Travis-CI](https://travis-ci.org/)

Travis-CI pulls code from the main branch (`source`), builds the website, runs tests, [and if it passed] it pushes the generated `_site` directory to `master` for GH-Pages.

Travis-CI setup was completed largely following a blog post from [Savas Labs](http://savaslabs.com/2016/10/25/deploy-jekyll-with-travis.html).

- Looks for changes in the `source branch`
- Builds the website
- Runs all tests
- If all tests pass
  - it will deploy `_site` contents to the `master branch` (Which is my GH-PAGES branch).
- Else
  - it will fail the build, notify me, and not update the website/master branch.

Travis-CI will check if all of my PRs will build before I am allowed to merge them with the `source branch`.

Travis-CI script located in `_scripts/cibuild`

### Tests

To run RuboCop

`$ rake rubocop`

To run tests

`$ rake test`

To run all rake tasks

`$ rake`

## Extra

This website is loosely inspired from (and originally based on) [Long-Haul](https://github.com/brianmaierjr/long-haul). I continue to make changes as I see fit.
