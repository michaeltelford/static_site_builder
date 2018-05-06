class HTMLTemplater
  EDITABLE_REGION = "<div id='editable_region'></div>".freeze
  DEFAULT_TEMPLATE = "lib/default_template.html".freeze

  attr_reader :template_filepath, :html

  # Initializes a HTML template with either a template_filepath to a HTML file
  # or a HTML string. Either way the HTML should be valid and contain the
  # EDITABLE_REGION. If no params are provided then the DEFAULT_TEMPLATE is
  # used instead. The DEFAULT_TEMPLATE uses bootstrap 4 (from a CDN).
  # The html takes precedence over the template_filepath if provided.
  def initialize(template_filepath: DEFAULT_TEMPLATE, html: nil)
    @template_filepath = template_filepath
    @html = html

    if not @html
      @html = File.read(@template_filepath)
    end

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
end
