# Static Site Builder

Build a HTML website from markdown files.

This gem will convert your markdown files into HTML files, embedding the generated HTML into a template (making up the full webpage). This gem's default [Bootstrap](https://getbootstrap.com/) template will be used unless you specify a template of your own. More on this further down.

## Installation

    $ gem install static_site_builder

This will add an executable called `site_builder` to your `$PATH`.

## Usage

```sh
$ mkdir -p ~/my_site
$ cd ~/my_site
$ echo "# My Amazing Website" > index.md
$ site_builder build
Site built with 1 HTML file(s):
./index.html
$ open index.html
```

That's it! In this instance, there will be a newly generated mobile friendly `index.html` file in the same directory.

Of course, you can specify an input and output directory as well as a custom HTML template to use instead of the default one.

For full usage of `site_builder`, see:

    $ site_builder help build

## Templating

The default template uses Bootstrap 4.1 to enable a stylish and responsive website design out of the box.

Custom templates are simply HTML files which include an editable region (inside a `<body>` tag) consisting of the following markdown:

```html
<div id="editable_region"></div>
```

The editable region `div` will be replaced with the generated HTML from your markdown.

Of course you can include anything else that's common to your site in your template e.g.

- Navigation menu
- Links to your own style sheets
- Javascript applying to the whole site
- etc...

If using your own template, you must ensure it's valid HTML and that it contains the editable region `div` seen above. That's it.

You can use this gem's built in [default template](https://github.com/michaeltelford/static_site_builder/blob/master/templates/default_template.html) as an example.

## Beyond Markdown

Markdown makes writing static content easy, but it doesn't support more advanced HTML features (like forms etc). You can write your own HTML within the markdown document and it will be parsed as is. Alternatively, you can use the [`yart`](https://github.com/michaeltelford/yart) gem to turn Ruby into HTML, removing the boiler plate from generating HTML.

For example, placing the following code snippet inside your markdown will create a contact form in the generated HTML page:

    ```yart
    form action: "/api/contact" do
        input type: :email, required: true
        input type: :textarea, required: true
        button(type: :submit) { "Send Message" }
    end
    ```

The important bit here is the ` ```yart ` line which tells the `YART` parser to render this snippet of Ruby into HTML. Check out the [`yart README`](https://github.com/michaeltelford/yart) for more details on how to use the `YART` DSL.

## Development

I welcome community contribution as long as the changes makes sense.

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `*.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/michaeltelford/static_site_builder. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://github.com/michaeltelford/static_site_builder/blob/master/LICENSE.txt).

## Code of Conduct

Everyone interacting in the StaticSiteBuilder project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/michaeltelford/static_site_builder/blob/master/CODE_OF_CONDUCT.md).
