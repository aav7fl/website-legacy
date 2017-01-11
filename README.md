##My personal website
https://www.kyleniewiada.org/


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

This website is loosely inspired from (and originally based on) [Long-Haul](https://github.com/brianmaierjr/long-haul). I continue to make changes as I see fit.

##This website build uses [BrowserSync](https://browsersync.io/). It keeps your browsers in sync so I can develop in my VM and sync across to my physical machine for the results.
