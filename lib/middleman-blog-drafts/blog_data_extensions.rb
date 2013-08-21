module Middleman
  module Blog
    module Drafts
      # An extension to let {Middleman::Blog::BlogData} know about all draft
      # articles in the site.
      module BlogDataExtensions
        def drafts(app=nil, options=nil)
          @_drafts ||= Middleman::Blog::Drafts::Data.new(self, app, options)
        end

        # A draft BlogArticle for the given path, or nil if one doesn't exist.
        # @return [Middleman::Sitemap::Resource]
        def draft(path)
          article = @app.sitemap.find_resource_by_path(path.to_s)
          if article && article.is_a?(BlogArticle)
            article
          else
            nil
          end
        end
      end

      # A store of all the draft articles in the site. Accessed via "blog.drafts" in
      # templates.
      class Data
        attr_reader :options, :path_matcher, :matcher_indexes

        # @private
        def initialize(blog_data, app, options)
          @blog_data = blog_data
          @options   = options
          @app       = app

          # A list of resources corresponding to draft articles
          @_drafts = []

          matcher = Regexp.escape(options.sources).
              sub(/^\//, "").
              sub(":title", "([^/]+)")

          @path_matcher = /^#{matcher}/

          # Build a hash of part name to capture index, e.g. {"year" => 0}
          @matcher_indexes = {}
          options.sources.scan(/:title/).
            each_with_index do |key, i|
              @matcher_indexes[key[1..-1]] = i
            end
          # The path always appears at the end.
          @matcher_indexes["path"] = @matcher_indexes.size
        end

        # Updates' blog draft articles destination paths to be the
        # permalink.
        # @return [void]
        def manipulate_resource_list(resources)
          @_drafts = []
          used_resources = []

          resources.each do |resource|
            if resource.path =~ @path_matcher
              resource.extend BlogArticle
              resource.extend DraftArticle

              next unless @app.environment == :development

              # compute output path:
              resource.destination_path = options.permalink.
                sub(':title', resource.slug)

              resource.destination_path = Middleman::Util.normalize_path(resource.destination_path)

              @_drafts << resource
            end

            used_resources << resource
          end

          used_resources
        end

        # A list of all draft articles.
        # @return [Array<Middleman::Sitemap::Resource>]
        def articles
          @_drafts
        end
      end
    end
  end
end
