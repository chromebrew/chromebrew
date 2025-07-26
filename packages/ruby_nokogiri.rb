require 'buildsystems/ruby'

class Ruby_nokogiri < RUBY
  description 'Nokogiri (鋸) makes it easy and painless to work with XML and HTML from Ruby.'
  homepage 'https://nokogiri.org'
  version "1.18.9-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_racc' # R

  conflicts_ok
  no_compile_needed
end
