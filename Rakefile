require 'html/proofer'
require 'rubocop/rake_task'
require 'jekyll'

task default: [:rubocop, :html_proofer]

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
      'http://localhost:4000',
      /.*discussions.apple.com.*/, # Apple blocking Travis CI/typhoeus
      '#!'
    ],
    check_html: 'true',
    empty_alt_ignore: 'true',
    only_4xx: 'true'
  ).run
end

desc 'Run RuboCop'
task :rubocop do
  RuboCop::RakeTask.new
end
