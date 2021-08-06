# Require any non lib code here to enable a single require.
require "fileutils"
require "redcarpet"

# Require all lib files here to enable a single require.
require "static_site_builder/version"
require "static_site_builder/renderers/renderer"
require "static_site_builder/renderers/yart_renderer"
require "static_site_builder/renderers/markdown_renderer"
require "static_site_builder/renderers/template_renderer"

module StaticSiteBuilder
  # Takes a markdown_dirpath, finds all "*.md" files and converts each to a
  # "*.html" file in order to build a static website. A template is used to
  # embed each built webpage in. The output_dirpath will default to the
  # markdown_dirpath if not set.
  def self.build_website(markdown_dirpath, template, output_dirpath=nil)
    pattern = "#{markdown_dirpath}/*.md"

    Dir.glob(pattern).map { |f| self.build_webpage(f, template, output_dirpath) }
  end

  private

  # Takes a markdown_filepath, reads and converts its contents to html before
  # creating a html file of the same name in the output_dirpath directory.
  # If not provided, the output_dirpath will be the same directory as the
  # markdown file. The output_dirpath will be created if not already.
  # Note: If the html file already exists its contents will be overwritten.
  # A template is used to house the html body in, creating a full webpage.
  def self.build_webpage(markdown_filepath, template, output_dirpath=nil)
    markdown_filepath = self.remove_trailing_slash(markdown_filepath)
    output_dirpath = self.remove_trailing_slash(output_dirpath)

    markdown = File.read(markdown_filepath)
    html = self.apply_renderers(template, markdown)

    dirpath = File.dirname(markdown_filepath)
    output_dirpath ||= dirpath
    FileUtils.mkdir_p(output_dirpath) unless Dir.exist?(output_dirpath)

    filename_with_md_ext = File.basename(markdown_filepath)
    filename_without_md_ext = filename_with_md_ext.gsub(".md", "")

    html_filepath = "#{output_dirpath}/#{filename_without_md_ext}.html"
    File.open(html_filepath, "w") { |f| f.write(html) }

    html_filepath
  end

  # Removes the trailing / (if present) and returns.
  def self.remove_trailing_slash(filepath)
    return filepath unless filepath.end_with?("/")

    filepath.chop
  end

  # Apply the necessary renderers to the Markdown, returning a HTML String.
  def self.apply_renderers(template, markdown)
    markdown = YARTRenderer.new(markdown).render
    html_body = MarkdownRenderer.new(markdown).render
    template.render(html_body)
  end
end
