require 'buildsystems/ruby'

class Ruby_nokogiri < RUBY
  description 'Nokogiri (鋸) makes it easy and painless to work with XML and HTML from Ruby.'
  homepage 'https://nokogiri.org'
  version "1.19.1-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '523c41e8ffb1763b2ed8fb1dfc555cd7f990eac08c599a1c9054a90245bfb01e',
     armv7l: '523c41e8ffb1763b2ed8fb1dfc555cd7f990eac08c599a1c9054a90245bfb01e',
       i686: 'c48183cea55c4e9f338ec3e8a27f81f006533d05674729002fb28fe56851a5e0',
     x86_64: '2e3e19a62b7dd04cc169a6a7bf38f998bf415d112d413a5df1c1d36cd7547ff7'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R
  depends_on 'ruby_mini_portile2' # R
  depends_on 'ruby_racc' # R
  depends_on 'xzutils' # R
  depends_on 'zlib' # R

  conflicts_ok
  gem_compile_needed
end
