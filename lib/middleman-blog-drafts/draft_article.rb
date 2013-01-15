module Middleman
  module Blog
    module Drafts
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
          @_path_parts ||= app.blog.drafts.path_matcher.match(path).captures

          @_path_parts[app.blog.drafts.matcher_indexes[part]]
        end

        # Returns current date as we can't guess when the article will be published
        #
        # We need this in place or the layout used for blog posts might blow up
        #
        # @return [TimeWithZone]
        def date
          Time.now.in_time_zone
        end
      end
    end
  end
end
