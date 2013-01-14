module Middleman
  module Blog
    module Drafts
      # An extension to let {Middleman::Blog::BlogData} know about all draft
      # articles in the site.
      module BlogDataExtensions
        def drafts(options=nil)
          @_drafts ||= Middleman::Blog::Drafts::Data.new(self, options)
        end
      end

      # A store of all the draft articles in the site. Accessed via "blog.drafts" in
      # templates.
      class Data
        attr_reader :options

        # @private
        def initialize(blog_data, options)
          @blog_data = blog_data
          @options = options

          # A list of resources corresponding to draft articles
          @_drafts = []

          matcher = Regexp.escape(options.sources).
              sub(/^\//, "").
              sub(":title", "([^/]+)")

          subdir_matcher = matcher.sub(/\\\.[^.]+$/, "(/.*)$")

          @path_matcher = /^#{matcher}/
          @subdir_matcher = /^#{subdir_matcher}/

          # Build a hash of part name to capture index, e.g. {"year" => 0}
          @matcher_indexes = {}
          options.sources.scan(/:title/).
            each_with_index do |key, i|
              @matcher_indexes[key[1..-1]] = i
            end
          # The path always appears at the end.
          @matcher_indexes["path"] = @matcher_indexes.size
        end
      end
    end
  end
end
