require 'bundler'
Bundler::GemHelper.install_tasks

require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:cucumber, 'Run features that should pass') do |t|
  t.cucumber_opts = "--color --tags ~@wip --strict --format #{ENV['CUCUMBER_FORMAT'] || 'Fivemat'}"
end

Cucumber::Rake::Task.new(:cucumber_wip, 'Run only WIP features') do |t|
  t.cucumber_opts = "--color --tags @wip --strict --format #{ENV['CUCUMBER_FORMAT'] || 'Fivemat'}"
end

task :test => :cucumber
task :wip => :cucumber_wip
task :default => [:test]

require 'rake/clean'

begin
  require 'cane/rake_task'

  desc "Run cane to check quality metrics"
  Cane::RakeTask.new(:quality) do |cane|
    cane.no_style = true
    cane.no_doc = true
    cane.abc_glob = "lib/middleman-blog-drafts/**/*.rb"
    cane.style_glob = "lib/middleman-blog-drafts/**/*.rb"
  end

  task :default => [:quality]
rescue LoadError
  warn "cane not available, quality task not provided."
end

desc "Build HTML documentation"
task :doc do
  sh 'bundle exec yard'
end

