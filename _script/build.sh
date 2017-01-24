#!/bin/bash

# Enable error reporting to the console.
set -e

echo 'bundle time'
# Install bundles if needed.
bundle check || bundle install
# Build the site
echo 'build site'
bundle exec jekyll build

# Checkout `master` and remove everything.
git clone https://${GH_TOKEN}@github.com/aav7fl/aav7fl.github.io.git ../aav7fl.github.io.master
cd ../aav7fl.github.io.master
git checkout master
rm -rf *

# Copy generated HTML site from source branch in original repository.
# Now the `master` branch will contain only the contents of the _site directory.
cp -R ../aav7fl.github.io/_site/* .

# Make sure we have the updated .travis.yml file so tests won't run on master.
cp ../aav7fl.github.io/.travis.yml .
git config user.email ${GH_EMAIL}
git config user.name "aavf7l-bot"

# Commit and push generated content to `master` branch.
echo 'git status'
git status
echo 'git add -A'
git add -A .
echo 'git status'
git status
echo 'git commit'
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"
echo 'git push'
git push --quiet origin `master` > /dev/null 2>&1
