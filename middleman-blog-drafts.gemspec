# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "middleman-blog-drafts/version"

Gem::Specification.new do |s|
  s.name        = "middleman-blog-drafts"
  s.version     = Middleman::Blog::Drafts::VERSION
  s.authors     = ["Fabio Rehm"]
  s.email     = ["fgrehm@gmail.com"]
  s.description = %q{middleman-blog extension for working with draft articles}
  s.summary     = s.description
  s.homepage    = "https://github.com/fgrehm/middleman-draft-articles"

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_runtime_dependency("middleman-core", [">= 3.1.4"])
  s.add_runtime_dependency("middleman-blog")
end
