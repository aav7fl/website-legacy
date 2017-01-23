##My personal website
https://www.kyleniewiada.org/

[![Build Status](https://travis-ci.org/aav7fl/aav7fl.github.io.svg?branch=master)](https://travis-ci.org/aav7fl/aav7fl.github.io)


These following steps *should* work to get setup. But I might have missed something..

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

This website is loosely inspired from (and originally based on) [Long-Haul](https://github.com/brianmaierjr/long-haul). I continue to make changes as I see fit.

##Extra information

This website build uses [BrowserSync](https://browsersync.io/). It keeps the browsers in sync so I can develop in my VM and sync across to my physical machine/mobile devices for the results.

Run RuboCop with `rake rubocop`

Run tests with `rake test`

Run Travis-CI script with `bash ./script/cibuild`

Launch Dev environment (Jekyll Server/Browser-Sync/Website) with `gulp`
