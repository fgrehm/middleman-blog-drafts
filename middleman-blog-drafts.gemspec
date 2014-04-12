# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "middleman-blog-drafts/version"

Gem::Specification.new do |s|
  s.name        = "middleman-blog-drafts"
  s.version     = Middleman::Blog::Drafts::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Fabio Rehm", "Serge Gebhardt"]
  s.email       = ["fgrehm@gmail.com", "serge.gebhardt@gmail.com"]
  s.homepage    = "https://github.com/fgrehm/middleman-draft-articles"
  s.summary     = %q{middleman-blog extension adding draft articles}
  s.description = s.summary
  s.license     = "MIT"

  s.files         = `git ls-files -z`.split("\0")
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features|fixtures)/})
  s.require_paths = ["lib"]

  s.required_ruby_version = '>= 1.9.3'

  s.add_runtime_dependency("middleman-core", ["~> 3.2"])
  s.add_runtime_dependency("middleman-blog", ["~> 3.5"])
end
