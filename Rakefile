require "bundler/gem_tasks"
require "rake/testtask"
require "static_site_builder"

task :default => :help

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :help do
  system "rake -T"
end

desc "Builds a static site from ./markdown/*.md files"
task :build_site do
  template = HTMLTemplater.new
  puts StaticSiteBuilder.build_website "./markdown", template
end
