require 'English'
require 'html-proofer'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'jekyll'

task default: [:test]

task :build, [:options] do |_t, args|
  # Build twice to handle FastImage issue of non-existent images on init build
  puts 'Building site...'.yellow.bold
  args.with_defaults(options: {})
  orig_stdout = STDOUT.clone
  STDOUT.reopen('/dev/null', 'w')
  Jekyll::Commands::Build.process({})
  STDOUT.reopen(orig_stdout)
  Jekyll::Commands::Build.process(args[:options])
end

task :build_watch do
  # Build the site with custom options such as drafts enabled.
  puts 'Building site with drafts...'.yellow.bold
  options = {
    'incremental' => true,
    'show_drafts' => true,
    'watch'       => true
  }
  Rake::Task['build'].invoke(options)
end

task :serve do
  puts 'Serving site...'.yellow.bold
  options = {
    'incremental' => true,
    'serving'     => true,
    'show_drafts' => true,
    'watch'       => true
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
    file_ignore: [%r{_site/amp/.*}], # Ignore AMP. Handled by AMP-Validator
    http_status_ignore: [999], # `999 No Error` from LinkedIn
    internal_domains: ['www.kyleniewiada.org'],
    url_ignore:
    [
      %r{.*apple.com/.*}, # Apple blocking Travis CI/typhoeus
      %r{.*savaslabs.com/.*}, # SavasLabs blocking Travis CI/typhoeus
      %r{.*/#comment-.*}, # Internal Disqus comments
      %r{.*pj64-emu.com/.*}, #PJ-64 has weird SSL properties that fails HTML Proofer
      %r{https://www.kyleniewiada.org/amp/.*} # Interal AMP Pages.
    ]
  ).run
end

desc 'Test website AMP validation'
task :amp do
  puts 'Running AMP Validator...'.yellow.bold
  amp_dir = '_site/amp'
  system("find #{amp_dir} -iname '*.html' | xargs -L1 amphtml-validator")
  if $CHILD_STATUS.exitstatus.zero?
    puts 'AMP Validator finished successfully.'.green
  else
    puts 'AMP Validator FAILED.'.red.bold
    exit($CHILD_STATUS.exitstatus)
  end
end

desc 'Test JSON-LD'
task :json do
  puts 'Testing JSON-LD against Google Structured Data Testing
   Tool...'.yellow.bold
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = 'spec/*_spec.rb'
  end
  Rake::Task['spec'].execute
end

desc 'Run RuboCop'
task :rubocop do
  puts 'Running RuboCop Validator...'.yellow.bold
  RuboCop::RakeTask.new
end

desc 'Run all tests except the JSON validator'
task :test do
  Rake::Task['build'].invoke
  # Rake::Task['json'].invoke
  Rake::Task['rubocop'].invoke
  Rake::Task['html_proofer'].invoke
  Rake::Task['amp'].invoke
end
