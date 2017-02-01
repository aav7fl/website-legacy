require 'html/proofer'
require 'rubocop/rake_task'
require 'jekyll'

task default: [:rubocop, :test]

task :build do
  puts 'Building site...'.yellow.bold
  # Build once because and ignore everything because
  # Fastimage doesn't know about the images that exist yet.
  sh 'bundle exec jekyll build > /dev/null  2>&1'
  sh 'bundle exec jekyll build'
end

task :clean do
  puts 'Cleaning up _site...'.yellow.bold
  Jekyll::Commands::Clean.process({})
end

desc 'Build and test website'
task :html_proofer do
  Rake::Task['build'].invoke
  puts 'Running html proofer...'.yellow.bold
  HTML::Proofer.new(
    './_site',
    url_ignore:
    [
      %r{.*discussions.apple.com/.*}, # Apple blocking Travis CI/typhoeus
      %r{https://www.kyleniewiada.org.*} # Internal_domains doesn't handle this
    ],
    file_ignore: [%r{_site/amp/.*}], # Ignore AMP Pages
    # internal_domains: ['www.kyleniewiada.org'],
    allow_hash_href: 'false',
    check_html: 'true',
    favicon: 'true',
    only_4xx: 'true' # Used to hande `999 No Error` from LinkedIn
  ).run
end

desc 'Run all tests'
task :test do
  Rake::Task['html_proofer'].invoke
end

desc 'Run RuboCop'
task :rubocop do
  RuboCop::RakeTask.new
end
