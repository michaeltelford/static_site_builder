$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)

require "static_site_builder"
require "minitest/autorun"

def markdown_dir
  "./test/markdown"
end

def output_dir
  "#{markdown_dir}/html"
end

def default_template
  StaticSiteBuilder::TemplateRenderer.new
end
