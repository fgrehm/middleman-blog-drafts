module Middleman
  module Blog
    module Drafts
      # Drafts-related helpers that are available to the Middleman application in +config.rb+ and in templates.
      module Helpers
        # Get a {Resource} with mixed in {BlogArticle} methods representing the
        # current article.
        # @return [Middleman::Sitemap::Resource]
        def current_article
          blog.draft(current_resource.path)
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
