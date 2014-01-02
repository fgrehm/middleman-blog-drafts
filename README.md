# middleman-blog-drafts

[![Build Status](https://travis-ci.org/fgrehm/middleman-blog-drafts.png?branch=master)](https://travis-ci.org/fgrehm/middleman-blog-drafts)

middleman-blog-drafts is an addon for [middleman-blog](https://github.com/middleman/middleman-blog)
that simplifies draft posts creation and publishing.

## Install

If you're just getting started, install the required gems and generate a new blog project:

```terminal
gem install middleman middleman-blog-drafts
middleman init MY_BLOG_PROJECT --template=blog
```

Then add `middleman-blog-drafts` to your `Gemfile` and activate the extension in your `config.rb`:

```ruby
activate :drafts
```

## Generating drafts

```terminal
middleman draft 'My awesome new blog post'
```

## Publishing drafts

```terminal
middleman publish source/drafts/my-awesome-new-blog-post.markdown
```

## Listing drafts on a page

```erb
<% if drafts.any? %>
  <ul>
    <% drafts.each do |draft| %>
      <li><%= link_to draft.title, draft.path %></li>
    <% end %>
  </ul>
<% end %>
```

As drafts won't be be available in the generated page by default, checking whether there are any is enough to decide whether to render the listing or not.

## Configuration options

`build`: when `true`, the drafts will be available unconditionally. If not given, the drafts will be available in middlemans development mode and unavailable in `middleman build`.

This allows you to control the behaviour, for example if you have a preview instance of your blog. One way to do so would be to set it based on an environment variable:

```ruby
activate :drafts do |drafts|
  drafts.build = true if ENV["SHOW_DRAFTS"]
end
```

This activates drafts in any environment where `SHOW_DRAFTS` is given and uses the default otherwise.

## Learn More

See the [blog extension guide](http://middlemanapp.com/basics/blogging/) for detailed
information on configuring and using the blog extension.

## Credits

Most of the code was based on the [middleman-blog](https://github.com/middleman/middleman-blog)
gem itself, so many thanks to everyone that helped out with it.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
