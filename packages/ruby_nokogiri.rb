require 'buildsystems/ruby'

class Ruby_nokogiri < RUBY
  description 'Nokogiri (鋸) makes it easy and painless to work with XML and HTML from Ruby.'
  homepage 'https://nokogiri.org'
  version "1.19.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'c12feadc7122b3d1d20d3802d9be8a966bee380fffb117dc51ef951e68e7a5ce',
     armv7l: 'c12feadc7122b3d1d20d3802d9be8a966bee380fffb117dc51ef951e68e7a5ce',
       i686: 'adf7f0f2aa4028f603da6ece2a0573ec29e1002c324e08ae338286f3e241cb5d',
     x86_64: '738d1c5977805dca87c79d7ed640497f0164e0ca4eea27defd263758eead1f91'
  })

  depends_on 'ruby_mini_portile2' # R
  depends_on 'ruby_racc' # R

  conflicts_ok
  gem_compile_needed
end
