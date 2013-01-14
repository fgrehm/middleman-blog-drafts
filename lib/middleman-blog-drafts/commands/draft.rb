require 'middleman-core/cli'

module Middleman
  module Cli
    # This class provides a "draft" command for the middleman CLI.
    class Draft < Thor
      include Thor::Actions

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
        if shared_instance.blog.respond_to? :drafts
          @title = title
          @slug = title.parameterize

          draft_path = shared_instance.blog.drafts.options.sources.
            sub(':title', @slug)

          template "draft.tt", File.join(shared_instance.source_dir, draft_path + shared_instance.blog.options.default_extension)
        else
          raise Thor::Error.new "You need to activate the drafts extension in config.rb before you can create an article"
        end
      end
    end
  end
end
