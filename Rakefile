require 'html/proofer'
# rake test
desc "build and test website"
task :test do
  sh "bundle exec jekyll build"
  HTML::Proofer.new("./_site", {
    :url_ignore => [
      'http://localhost:4000',
      'https:\/\/discussions\.apple\.com\/thread\/.*',#Apple blocking Travis CI/typhoeus
      '#!'
    ],
    :check_html => true,
    :empty_alt_ignore => true,
    :only_4xx => true
  }).run
end

task :default => [:test]
