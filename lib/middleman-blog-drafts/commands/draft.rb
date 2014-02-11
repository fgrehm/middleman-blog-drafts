require 'middleman-core/cli'
require 'middleman-blog/uri_templates'

module Middleman
  module Cli
    # This class provides a "draft" command for the middleman CLI.
    class Draft < Thor
      include Thor::Actions
      include Blog::UriTemplates

      check_unknown_options!

      namespace :draft

      # Template files are relative to this file
      # @return [String]
      def self.source_root
        File.dirname(__FILE__)
      end

      # Tell Thor to exit with a nonzero exit code on failure
      def self.exit_on_failure?
        true
      end

      desc "draft TITLE", "Create a new draft for a blog article"
      def draft(title)
        shared_instance = ::Middleman::Application.server.inst

        # This only exists when the config.rb sets it!
        unless shared_instance.blog.respond_to? :drafts
          raise Thor::Error.new "You need to activate the drafts extension in config.rb before you can create an article"
        end

        @title = title
        @slug = safe_parameterize title

        path_template = shared_instance.blog.drafts.source_template
        draft_path = apply_uri_template path_template, title: @slug
        draft_path << shared_instance.blog.options.default_extension

        template "draft.tt", File.join(shared_instance.source_dir, draft_path)
      end
    end
  end
end
