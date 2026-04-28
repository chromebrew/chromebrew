require 'buildsystems/ruby'

class Ruby_nokogiri < RUBY
  description 'Nokogiri (鋸) makes it easy and painless to work with XML and HTML from Ruby.'
  homepage 'https://nokogiri.org'
  version "1.19.3-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'a963ebc101b72294cdc6bc81d37aba68b261f6272deea983f0506314bf31a792',
     armv7l: 'a963ebc101b72294cdc6bc81d37aba68b261f6272deea983f0506314bf31a792',
       i686: '43cccdbe04cc3c79a5decc4c90d5db5b0e3cb8cefca26ad88d63abdd3b9ad0c6',
     x86_64: '9d316daae5340e91618f9c844f1eadcf41462b68982da8f7ff7a018cd756dcef'
  })

  depends_on 'glibc' => :library
  depends_on 'ruby' => :library
  depends_on 'ruby_mini_portile2' # R
  depends_on 'ruby_racc' # R
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library

  conflicts_ok
  gem_compile_needed
end
