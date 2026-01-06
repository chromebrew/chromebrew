require 'buildsystems/ruby'

class Ruby_nokogiri < RUBY
  description 'Nokogiri (鋸) makes it easy and painless to work with XML and HTML from Ruby.'
  homepage 'https://nokogiri.org'
  version "1.19.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  depends_on 'ruby_mini_portile2' # R
  depends_on 'ruby_racc' # R

  conflicts_ok
  gem_compile_needed
end
