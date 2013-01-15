require "middleman-core"

require "middleman-blog-drafts/commands/draft"
require "middleman-blog-drafts/commands/publish"
require "middleman-blog-drafts/version"

::Middleman::Extensions.register(:drafts) do
  require 'middleman-blog-drafts/extension'
  ::Middleman::Blog::Drafts
end
