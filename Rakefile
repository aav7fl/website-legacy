require 'html/proofer'
# rake test
desc "build and test website"
task :test do
  sh "bundle exec jekyll build"
  HTML::Proofer.new("./_site", {
    :href_ignore => [
      'http://localhost:4000',
      '#!'
    ],
    :check_html => true,
    :empty_alt_ignore => true,
    :only_4xx => true
  }).run
end

task :default => [:test]
