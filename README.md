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

4. Install NPM

  `sudo apt-get install -y nodejs npm`

5. NPM Dependencies

  `npm install`

6. Launch Jekyll Server/Browser-Sync/Website

  `gulp`

This website is based off of [Long-Haul](https://github.com/brianmaierjr/long-haul). I continue to make changes as I see fit.
