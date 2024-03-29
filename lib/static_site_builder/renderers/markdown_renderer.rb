module StaticSiteBuilder
  # Renders Markdown into HTML. Any existing HTML inside the Markdown will NOT be removed,
  # allowing other renderers to be applied before this one where required.
  class MarkdownRenderer < Renderer
    attr_reader :markdown

    def initialize(markdown)
      super()

      @markdown = markdown
      @redcarpet = Redcarpet::Markdown.new(
        Redcarpet::Render::HTML,
        tables: true,
        fenced_code_blocks: true,
        autolink: true,
        strikethrough: true,
        superscript: true,
        underline: true,
        highlight: true,
        quote: true,
        footnotes: true,
      )
    end

    # Returns a String of HTML (rendered from the given Markdown).
    def render
      @redcarpet.render(@markdown)
    end
  end
end
