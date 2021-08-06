def yart_installed?
  require("yart")
  true
rescue LoadError
  puts "Skipping YART rendering because the 'yart' gem isn't installed"
  false
end

$yart_installed = yart_installed?

module StaticSiteBuilder
  # Renders YART snippets into HTML (within a Markdown document).
  class YARTRenderer < Renderer
    YART_START_LINE   = "```yart"
    YART_END_LINE     = "```"
    YART_PARSE_ERROR  = "'YART.parse' detected in markdown, remove it leaving just the block to be parsed by YART"

    attr_reader :markdown

    def initialize(markdown)
      super()

      @markdown = markdown
    end

    # Returns a String of Markdown (having recursively rendered any found YART snippets into HTML).
    def render
      return @markdown unless $yart_installed

      lines = @markdown.split("\n")
      return @markdown unless yart_snippet?(lines)

      yart_lines = extract_yart_lines(lines)
      yart_snippet = yart_lines[1..-2].join("\n")
      raise YART_PARSE_ERROR if yart_snippet.include?("YART.parse")

      html = YART.parse { eval(yart_snippet) }
      @markdown.sub!(yart_lines.join("\n"), html)

      render
    end

    private

    def yart_snippet?(lines)
      lines.include?(YART_START_LINE) && lines.include?(YART_END_LINE)
    end

    def extract_yart_lines(lines)
      start  = lines.find_index(YART_START_LINE)
      finish = lines.find_index(YART_END_LINE)

      lines[start..finish]
    end
  end
end
