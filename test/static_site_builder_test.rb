require "test_helper"

class StaticSiteBuilderTest < Minitest::Test
  def setup
    delete_output_files
  end

  def test_version
    refute_nil StaticSiteBuilder::VERSION
  end

  def test_build
    html_files = StaticSiteBuilder.build_website(markdown_dir, default_template, output_dir)

    assert_equal([
      "#{output_dir}/index.html",
      "#{output_dir}/contact.html",
    ], html_files)
    assert_equal expected_index_html, File.read("#{output_dir}/index.html")
    assert_equal expected_contact_html, File.read("#{output_dir}/contact.html")
  end

  def test_template
    custom_template = StaticSiteBuilder::TemplateRenderer.new(
      template_filepath: custom_template_path,
      gem_included_template: false,
    )
    html_files = StaticSiteBuilder.build_website(markdown_dir, custom_template, output_dir)
    template_test_id = "<body id='test'>"

    assert_equal([
      "#{output_dir}/index.html",
      "#{output_dir}/contact.html",
    ], html_files)
    assert File.read("#{output_dir}/index.html").include?(template_test_id)
    assert File.read("#{output_dir}/contact.html").include?(template_test_id)
  end

  def test_executable
    `./exe/site_builder build --in #{markdown_dir} --out #{output_dir}`

    assert_equal([
      "#{output_dir}/index.html",
      "#{output_dir}/contact.html",
    ], Dir.glob("#{output_dir}/*.html"))
    assert_equal expected_index_html, File.read("#{output_dir}/index.html")
    assert_equal expected_contact_html, File.read("#{output_dir}/contact.html")
  end

  private

  def expected_index_html
    <<~HTML
      <!doctype html>
      <html lang=\"en\">
      <head>
        <meta charset=\"utf-8\">
        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, shrink-to-fit=no\">
        <link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css\" integrity=\"sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB\" crossorigin=\"anonymous\">
      </head>
      <body>
        <h1>Test Site</h1>

      <p>This is a test site built using <code>static_site_builder</code>.</p>

      <p>Enjoy! :-)</p>

      <h2>Usage</h2>

      <p>See its repository for the full usage instructions.</p>

      <h2>Contact</h2>

      <p>See the <a href=\"contact.html\">Contact</a> page for contact information.</p>

      </body>
      </html>
    HTML
  end

  def expected_contact_html
    <<~HTML
      <!doctype html>
      <html lang=\"en\">
      <head>
        <meta charset=\"utf-8\">
        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1, shrink-to-fit=no\">
        <link rel=\"stylesheet\" href=\"https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css\" integrity=\"sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB\" crossorigin=\"anonymous\">
      </head>
      <body>
        <h1>Contact</h1>

      <p><a href=\"index.html\">Home</a></p>

      <h2>Contact Us</h2>

      <form action='/api/contact'><input type='email' required></input><input type='text' required></input><button type='submit'>Send Message</button></form>

      <p>Another YART snippet:</p>

      <h1>Hello World</h1>

      </body>
      </html>
    HTML
  end
end
