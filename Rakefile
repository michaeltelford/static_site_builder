require "bundler/gem_tasks"
require "rake/testtask"
require "static_site_builder"

task default: :help

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :help do
  system "rake -D"
end

desc "Builds a static HTML site from markdown files"
task :build_site, :markdown_dirpath, :output_dirpath do |t, args|
  args.with_defaults(markdown_dirpath: "./markdown")
  args.with_defaults(output_dirpath: "./markdown/html")
  puts StaticSiteBuilder.build_website(
    args[:markdown_dirpath],
    StaticSiteBuilder::TemplateRenderer.new,
    args[:output_dirpath]
  )
end
