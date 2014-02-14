require 'middleman-blog'

activate :blog do |b|
  b.prefix = 'blog'
end

activate :drafts do |d|
  d.build = true
end
