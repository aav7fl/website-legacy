require 'html/proofer'
require 'rubocop/rake_task'
require 'jekyll'

task default: [:rubocop, :test]

task :build do
  puts 'Building site...'.yellow.bold
  Jekyll::Commands::Build.process(future: true)
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
      '#!' # Ignore internal URL used for JS Menu.
    ],
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
