module Middleman
  module Blog
    module Drafts
      class Options
        attr_accessor :sources, :layout

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
          require 'middleman-blog-drafts/blog_data_extensions'

          options = Options.new(options_hash)
          yield options if block_given?

          options.sources ||= "drafts/:title.html"

          ::Middleman::Blog::BlogData.send :include, BlogDataExtensions

          app.after_configuration do
            options.layout = blog.options.layout
            blog.drafts(options)
          end
        end
        alias :included :registered
      end
    end
  end
end
