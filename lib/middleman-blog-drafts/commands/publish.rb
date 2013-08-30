require 'middleman-core/cli'

module Middleman
  module Cli
    # This class provides a "publish" command for the middleman CLI.
    class Publish < Thor
      include Thor::Actions

      check_unknown_options!

      namespace :publish

      # Template files are relative to this file
      # @return [String]
      def self.source_root
        File.dirname(__FILE__)
      end

      # Tell Thor to exit with a nonzero exit code on failure
      def self.exit_on_failure?
        true
      end

      desc "publish DRAFT_PATH", "Publish a draft"
      method_option "date",
        :aliases => "-d",
        :desc => "The date to create the post with (defaults to now)"
      def publish(draft_path)
        shared_instance = ::Middleman::Application.server.inst

        # This only exists when the config.rb sets it!
        if shared_instance.blog.respond_to? :drafts
          @slug = draft_path.split('/').last.split('.').first.parameterize
          @date = options[:date] ? DateTime.parse(options[:date]) : DateTime.now

          draft_path    = File.expand_path draft_path
          extension     = File.extname draft_path

          article_path = shared_instance.blog.options.sources.
            sub(':year', @date.year.to_s).
            sub(':month', @date.month.to_s.rjust(2,'0')).
            sub(':day', @date.day.to_s.rjust(2,'0')).
            sub(':title', @slug)
          article_path = File.join(shared_instance.source_dir, article_path + extension)

          data, content = shared_instance.extensions[:frontmatter].data(draft_path)
          data = data.dup.tap { |d| d[:date] = Date.parse @date.strftime('%F') }

          create_file article_path, "#{YAML::dump(data).sub(/^--- !ruby.*$/, '---')}---\n#{content}"
          remove_file draft_path
        else
          raise Thor::Error.new "You need to activate the drafts extension in config.rb before you can publish an article"
        end
      end
    end
  end
end
