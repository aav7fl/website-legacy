#!/usr/bin/env bash
set -e # halt script on error

bundle exec rake rubocop
bundle exec rake test
