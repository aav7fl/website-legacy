require 'English'
require 'html-proofer'
require 'rubocop/rake_task'
require 'jekyll'

task default: [:test]

task :build do
  puts 'Building site...'.yellow.bold
  # Build twice to handle FastImage issue of non-existent images on init build
  orig_stdout = STDOUT.clone
  STDOUT.reopen('/dev/null', 'w')
  Jekyll::Commands::Build.process({})
  STDOUT.reopen(orig_stdout)
  Jekyll::Commands::Build.process({})
end

task :serve do
  puts 'Serving site...'.yellow.bold
  options = {
    'serving'     => true,
    'watch'       => true,
    'incremental' => true,
    'config'      => %w(_config.yml)
  }
  Jekyll::Commands::Serve.process(options)
end

task :clean do
  puts 'Cleaning up _site...'.yellow.bold
  Jekyll::Commands::Clean.process({})
end

desc 'Test website with html_proofer'
task :html_proofer do
  puts 'Running html proofer...'.yellow.bold
  HTMLProofer.check_directory(
    '_site/',
    allow_hash_href: 'true',
    check_html: 'true',
    check_opengraph: 'true',
    http_status_ignore: [999], # Used to hande `999 No Error` from LinkedIn
    internal_domains: ['www.kyleniewiada.org']
  ).run
end

desc 'Test website AMP validation'
task :amp do
  puts 'Running AMP Validator...'.yellow.bold
  amp_dir = '_site/amp'
  system("find #{amp_dir} -name *.html | xargs -L1 amphtml-validator")
  if $CHILD_STATUS.exitstatus.zero?
    puts 'AMP Validator finished successfully.'.green
  else
    puts 'AMP Validator FAILED.'.red.bold
    exit($CHILD_STATUS.exitstatus)
  end
end

desc 'Run RuboCop'
task :rubocop do
  puts 'Running RuboCop Validator...'.yellow.bold
  RuboCop::RakeTask.new
end

desc 'Run all tests'
task :test do
  Rake::Task['rubocop'].invoke
  Rake::Task['build'].invoke
  Rake::Task['html_proofer'].invoke
  Rake::Task['amp'].invoke
end
