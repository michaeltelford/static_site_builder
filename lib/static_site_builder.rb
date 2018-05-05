# Require all lib files here to enable a single require.
require "static_site_builder/version"
require "static_site_builder/html_templater"

# Require all external gems here to enable a single require.
require "redcarpet"

module StaticSiteBuilder
  # Converts markdown to html and returns it.
  def self.render(markdown)
    renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML,
      autolink: true,
      tables: true
    )
    renderer.render(markdown)
  end

  # Takes a markdown_filepath, reads and converts its contents to html before
  # creating a html file of the same name in the same directory e.g.
  # static/index.md -> static/index.html
  # Note: If the html file already exists it's contents will be overwritten.
  # A template is used to house the markdown/html body in, creating a full
  # webpage.
  def self.build_webpage(markdown_filepath, template)
    markdown = ""
    File.open(markdown_filepath){ |f| markdown = f.read }
    if markdown.empty?
      raise "Error reading markdown for file: '#{markdown_filepath}'"
    end

    html_body = self.render(markdown)
    html = template.render(html_body)

    dirpath = File.dirname(markdown_filepath)
    filename_with_md_ext = File.basename(markdown_filepath)
    filename_without_md_ext = filename_with_md_ext.split(".md")[0]
    html_filepath = "#{dirpath}/#{filename_without_md_ext}.html"

    File.open(html_filepath, "w") { |f| f.write(html) }
    html_filepath
  end

  # Takes a markdown_dirpath, finds all "*.md" files and converts each to a
  # "*.html" file in order to build a static website. A template is used to
  # embed each build webpage in.
  def self.build_website(markdown_dirpath, template)
    html_filepaths = []
    pattern = "#{markdown_dirpath}/*.md"

    Dir.glob(pattern).each do |f|
      html_filepaths << self.build_webpage(f, template)
    end

    html_filepaths
  end
end
