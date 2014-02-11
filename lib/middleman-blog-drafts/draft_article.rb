module Middleman
  module Blog
    module Drafts
      # A module that adds draft-article-specific methods to Resources.
      # A {DraftArticle} can be retrieved via {Blog::Drafts::Helpers#current_article} or
      # methods on {Blog::Drafts::Data} (accessible through BlogData#drafts).
      # @see http://rdoc.info/github/middleman/middleman/Middleman/Sitemap/Resource Middleman::Sitemap::Resource
      module DraftArticle
        # The "slug" of the draft article that shows up in its URL.
        # @return [String]
        def slug
          @_slug ||= path_part("title")
        end

        # Retrieve a section of the source path
        # @param [String] The part of the path, e.g. "title"
        # @return [String]
        def path_part(part)
          @_path_parts ||= blog_data.drafts.source_template.extract(path)
          @_path_parts[part.to_s]
        end

        # Returns current date as we can't guess when the article will be
        # published
        # We need this in place or the layout used for blog posts might blow up
        #
        # @return [TimeWithZone]
        def date
          Time.now.in_time_zone
        end

        # Extends resource data adding the date field
        #
        # @return [Thor::CoreExt::HashWithIndifferentAccess]
        def data
          super.dup.merge(date: date)
        end
      end
    end
  end
end
