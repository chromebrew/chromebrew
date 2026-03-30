require 'buildsystems/ruby'

class Ruby_nokogiri < RUBY
  description 'Nokogiri (鋸) makes it easy and painless to work with XML and HTML from Ruby.'
  homepage 'https://nokogiri.org'
  version "1.19.2-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '6ec5cb6c22021e4478d256d83a3f16acd766e8c92fc789672207e14bd8a89646',
     armv7l: '6ec5cb6c22021e4478d256d83a3f16acd766e8c92fc789672207e14bd8a89646',
       i686: '7e4d1aacc6f2a62373d95695fc8765275447f3e9c2ff09cad3e0ea8dbc222630',
     x86_64: 'faee0a6a0d9db5fe18e9b1d8fade910c81fb52c944956d9a3743948da0ef18a7'
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
