#!/bin/bash

# Enable error reporting to the console.
set -e

# Install bundles if needed.
bundle check || bundle install

# Build the site
bundle exec jekyll build

# Checkout `master` and remove everything.
git clone https://${GH_TOKEN}@github.com/${GH_USERNAME}/${GH_REPO}.git ../${GH_REPO}.${GH_DEST_BRANCH}
cd ../${GH_REPO}.${GH_DEST_BRANCH}
git checkout ${GH_DEST_BRANCH}
rm -rf *

# Copy generated HTML site from source branch in original repository.
# Now the `master` branch will contain only the contents of the _site directory.
cp -R ../${GH_REPO}/_site/* .

# Make sure we have the updated .travis.yml file so tests won't run on master.
cp ../${GH_REPO}/.travis.yml .
cp ../${GH_REPO}/CNAME .
git config user.email ${GH_EMAIL}
git config user.name "Travis-CI-bot"

# Commit and push generated content to `master` branch.
git status
git add -A .
git status
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"
git push --quiet origin master > /dev/null 2>&1
