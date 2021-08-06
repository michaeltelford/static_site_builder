$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "static_site_builder"
require "minitest/autorun"
require "fileutils"

def markdown_dir
  "./test/fixtures/markdown"
end

def output_dir
  "./test/fixtures/output"
end

def custom_template_path
  "./test/fixtures/template.html"
end

def default_template
  StaticSiteBuilder::TemplateRenderer.new
end

def delete_output_files
  return unless Dir.exist?(output_dir)

  output_files = Dir.glob("#{output_dir}/*.html")
  FileUtils.rm_rf(output_files)
end
