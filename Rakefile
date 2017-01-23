require 'html/proofer'
# rake test
desc "build and test website"
task :test do
  sh "bundle exec jekyll build"
  HTML::Proofer.new("./_site", {
    :url_ignore => [
      'http://localhost:4000',
      '#!'
    ],
    :check_html => true,
    :empty_alt_ignore => true,
    :only_4xx => true,
    :typhoeus => {
      :headers => {
        "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36"
      }
    }
  }).run
end

task :default => [:test]
