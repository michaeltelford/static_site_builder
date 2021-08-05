# Require any non lib code here to enable a single require.
require "fileutils"
require "redcarpet"

# Require all lib files here to enable a single require.
require "static_site_builder/version"
require "static_site_builder/html_templater"

module StaticSiteBuilder
  # Converts markdown to html and returns it.
  def self.render(markdown)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      tables: true,
      fenced_code_blocks: true,
      autolink: true,
      strikethrough: true,
      superscript: true,
      underline: true,
      highlight: true,
      quote: true,
      footnotes: true
    ).render(markdown)
  end

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

    html_body = self.render(markdown)
    html = template.render(html_body)

    dirpath = File.dirname(markdown_filepath)
    output_dirpath ||= dirpath
    FileUtils.mkdir_p(output_dirpath) unless Dir.exist?(output_dirpath)

    filename_with_md_ext = File.basename(markdown_filepath)
    filename_without_md_ext = filename_with_md_ext.gsub(".md", "")

    html_filepath = "#{output_dirpath}/#{filename_without_md_ext}.html"
    File.open(html_filepath, "w") { |f| f.write(html) }

    html_filepath
  end

  # Takes a markdown_dirpath, finds all "*.md" files and converts each to a
  # "*.html" file in order to build a static website. A template is used to
  # embed each built webpage in. The output_dirpath will default to the
  # markdown_dirpath if not set.
  def self.build_website(markdown_dirpath, template, output_dirpath=nil)
    pattern = "#{markdown_dirpath}/*.md"

    Dir.glob(pattern).map { |f| self.build_webpage(f, template, output_dirpath) }
  end

  # Removes the trailing / (if present) and returns.
  def self.remove_trailing_slash(filepath)
    return filepath unless filepath.end_with?("/")

    filepath.chop
  end
end
