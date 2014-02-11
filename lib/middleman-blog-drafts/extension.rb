require 'middleman-blog-drafts/helpers'

module Middleman
  module Blog
    class DraftsExtension < ::Middleman::Extension
      self.supports_multiple_instances = false

      option :sources,   'drafts/{title}.html',  'Pattern for matching draft articles (no template extensions)'
      option :permalink, '/drafts/{title}.html', 'Path draft are served from'
      option :build,     false,                  'Whether to include drafts when building the site'

      self.defined_helpers = [ ::Middleman::Blog::Drafts::Helpers ]

      def initialize(app, options_hash={}, &block)
        super
      end

      def after_configuration
        require 'middleman-blog/blog_data'
        require 'middleman-blog-drafts/blog_data_extensions'

        ::Middleman::Blog::BlogData.send :include, Drafts::BlogDataExtensions
        app.blog.drafts(app, options)
        app.sitemap.register_resource_list_manipulator(:blog_drafts,
          app.blog.drafts, false)
      end
    end
  end
end