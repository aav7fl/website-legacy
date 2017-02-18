#!/bin/bash
# https://github.com/savaslabs/savaslabs.github.io/blob/9434cee6fe1cce54de4bc0294da1c6e9f52476e0/_scripts/build.sh

# Enable error reporting to the console.
set -e

# Install gems
bundle install --deployment

# Install NPM packages
npm install

# Checkout `master` and remove everything.
git clone https://${GH_TOKEN}@github.com/${GH_USERNAME}/${GH_REPO}.git ../${GH_REPO}.${GH_DEST_BRANCH}
cd ../${GH_REPO}.${GH_DEST_BRANCH}
# Sick of `checkout` filling up my log
git checkout --quiet ${GH_DEST_BRANCH}
rm -rf *

# Copy generated HTML site from source branch in original repository.
# Now the `master` branch will contain only the contents of the _site directory.
cp -R ../${GH_REPO}/_site/* .

# Make sure we have the updated .travis.yml file so tests won't run on master.
cp ../${GH_REPO}/.travis.yml .
cp ../${GH_REPO}/CNAME .
git config --global user.email "travis@travis-ci.org"
git config --global user.name "Travis CI"

# Commit and push generated content to `master` branch.
git status
git add -A .
git status
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"
git push --quiet origin master > /dev/null 2>&1
