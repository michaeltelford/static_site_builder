module StaticSiteBuilder
  class HTMLTemplater
    EDITABLE_REGION = '<div id="editable_region"></div>'.freeze
    DEFAULT_TEMPLATE = "templates/default_template.html".freeze

    attr_reader :template_filepath, :gem_included_template, :html

    # Initializes a HTML template with either a template_filepath to a HTML file
    # or a HTML string. Either way the HTML should be valid and contain the
    # EDITABLE_REGION. If no params are provided then the DEFAULT_TEMPLATE is
    # used instead. The DEFAULT_TEMPLATE uses bootstrap 4 (from a CDN).
    # The html takes precedence over the template_filepath if provided.
    # The gem_included_template param distinguishes between a user created
    # template (on their local file system) and an included template (built
    # into the gem) e.g. the DEFAULT_TEMPLATE.
    def initialize(
        template_filepath: DEFAULT_TEMPLATE,
        gem_included_template: true,
        html: nil
      )
      @template_filepath = template_filepath
      @gem_included_template = gem_included_template
      @html = html

      read_template unless @html

      if not valid?
        raise "Missing editable region in template: #{EDITABLE_REGION}"
      end
    end

    # Returns wether or not the @html has an EDITABLE_REGION or not.
    # This method does not check if the HTML is valid or not. That's your
    # responsibility.
    def valid?
      @html.include?(EDITABLE_REGION)
    end

    # Renders the HTML template by replacing the EDITABLE_REGION with the
    # html_body param. It's your responsibility to ensure the html_body is valid
    # HTML within the context of a 'body' tag e.g. <body>#{html_body}</body>
    def render(html_body)
      @html.gsub(EDITABLE_REGION, html_body)
    end

    private

    # Reads the @template_filepath file and sets @html to it's contents.
    # The correct filepath is decided on based on wether or not the template is
    # built into the gem or on the user's local filesystem.
    def read_template
      path = @template_filepath
      if @gem_included_template
        relative_path = "../../#{@template_filepath}"
        path = File.expand_path(relative_path, File.dirname(__FILE__))
      end
      @html = File.read(path)
    end
  end
end
