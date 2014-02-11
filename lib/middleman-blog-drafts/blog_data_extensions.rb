require 'middleman-blog/uri_templates'
require 'middleman-blog-drafts/draft_article'

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

      # A store of all the draft articles in the site. Accessed via
      # {blog.drafts} in templates.
      class Data
        include UriTemplates

        # A URITemplate for the source file path relative to blog's :source_dir
        # @return [URITemplate]
        attr_reader :source_template

        # The configured options for this blog
        # @return [Thor::CoreExt::HashWithIndifferentAccess]
        attr_reader :options

        # @private
        def initialize(blog_data, app, options)
          @blog_data = blog_data
          @app       = app
          @options   = options

          # A list of resources corresponding to draft articles
          @_drafts = []

          @source_template = uri_template options.sources
          @permalink_template = uri_template options.permalink
        end

        # A list of all draft articles.
        # @return [Array<Middleman::Sitemap::Resource>]
        def articles
          @_drafts.sort_by(&:title)
        end

        # Update blog draft articles destination paths to be the permalink.
        # @return [void]
        def manipulate_resource_list(resources)
          @_drafts = []
          used_resources = []

          resources.each do |resource|
            if (params = extract_params(@source_template, resource.path))
              draft = convert_to_draft(resource)
              next unless build?(draft)

              # compute output path
              draft.destination_path =
                apply_uri_template @permalink_template, title: draft.slug

              @_drafts << resource
            end

            used_resources << resource
          end

          used_resources
        end

        # Whether or not a given draft should be included in the sitemap.
        # @param [DraftArticle] draft A draft article
        # @return [Boolean] Whether it should be built
        def build?(draft)
          @app.environment == :development || @options.build
        end

        private

        # Convert the resource into a DraftArticle.
        # @param [Sitemap::Resource] resource The resource to convert
        # @return [Sitemap::Resource] The converted resource
        def convert_to_draft(resource)
          return resource if resource.is_a? DraftArticle

          resource.extend BlogArticle
          resource.extend DraftArticle
          resource.blog_controller = @blog_data.controller

          resource
        end
      end
    end
  end
end
