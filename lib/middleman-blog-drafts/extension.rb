module Middleman
  module Blog
    module Drafts
      class Options
        attr_accessor :sources, :layout, :permalink

        def initialize(options={})
          options.each do |k,v|
            self.send(:"#{k}=", v)
          end
        end
      end

      class << self
        # Called when user `activate`s your extension
        def registered(app, options_hash={}, &block)
          require 'middleman-blog/extension'
          require 'middleman-blog/blog_data'
          require 'middleman-blog-drafts/draft_article'
          require 'middleman-blog-drafts/blog_data_extensions'

          options = Options.new(options_hash)
          yield options if block_given?

          options.sources   ||= "drafts/:title.html"
          options.permalink ||= "/drafts/:title.html"

          ::Middleman::Blog::BlogData.send :include, BlogDataExtensions
          app.send :include, Helpers

          app.after_configuration do
            options.layout = blog.options.layout
            blog.drafts(self, options)

            sitemap.register_resource_list_manipulator(
                                                     :blog_drafts,
                                                     blog.drafts,
                                                     false
                                                     )
          end
        end
        alias :included :registered
      end

      module Helpers
        # Get a {Resource} with mixed in {BlogArticle} methods representing the current article.
        # @return [Middleman::Sitemap::Resource]
        def current_article
          super || blog.draft(current_resource.path)
        end


        # Returns the list of drafts on the site.
        # @return [Array<Middleman::Sitemap::Resource>]
        def drafts
          blog.drafts.articles
        end
      end
    end
  end
end
