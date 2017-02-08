require 'English'
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

desc 'Test website with html_proofer'
task :html_proofer do
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

desc 'Test website AMP validation'
task :amp do
  amp_dir = '_site/amp'
  puts 'Running AMP Validator...'.yellow.bold
  command = "find #{amp_dir} -name *.html \
  | xargs -L1 bash -c \'output=$(amphtml-validator --format color $0;); \
  if [[ \"$output\" != *PASS ]]; then echo \"TEST FAILURE\" 1>&2 && exit 1; \
  else echo -e \"$output\"; fi;\'"
  system command
  if $CHILD_STATUS.exitstatus.zero?
    puts 'AMP Validator finished successfully.'.green
  else
    puts 'AMP Validator FAILED.'.red.bold
    exit(false)
  end
end

desc 'Run all tests'
task :test do
  Rake::Task['build'].invoke
  Rake::Task['html_proofer'].invoke
  Rake::Task['amp'].invoke
end

desc 'Run RuboCop'
task :rubocop do
  RuboCop::RakeTask.new
end
