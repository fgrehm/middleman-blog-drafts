require 'middleman-core/cli'
require 'date'
require 'middleman-blog/uri_templates'

module Middleman
  module Cli
    # This class provides a "publish" command for the middleman CLI.
    class Publish < Thor
      include Thor::Actions
      include Blog::UriTemplates

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
        @shared_instance = ::Middleman::Application.server.inst

        # This only exists when the config.rb sets it!
        unless @shared_instance.blog.respond_to? :drafts
          raise Thor::Error.new "You need to activate the drafts extension in config.rb before you can publish an article"
        end

        @slug = safe_parameterize draft_path.split('/').last.split('.').first
        @date = options[:date] ? Time.zone.parse(options[:date]) : Time.zone.now
        @draft_path = File.expand_path draft_path

        create_file article_path, article_content
        remove_file draft_path
      end

      private

      def article_path
        extension  = File.extname @draft_path
        path_template = @shared_instance.blog.source_template
        params = date_to_params(@date).merge(title: @slug)
        article_path = apply_uri_template path_template, params
        article_path = File.join(@shared_instance.source_dir, article_path + extension)
      end

      def article_content
        data, content = @shared_instance.extensions[:frontmatter].data(@draft_path)
        data = data.dup.tap { |d| d[:date] = Date.parse @date.strftime('%F') }

        "#{YAML::dump(data).sub(/^--- !ruby.*$/, '---')}---\n#{content}"
      end
    end
  end
end
