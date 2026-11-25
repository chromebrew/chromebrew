require 'buildsystems/ruby'

class Ruby_jaro_winkler < RUBY
  description 'Jaro_winkler is an implementation of Jaro-Winkler distance algorithm which is written in C extension and will fallback to pure Ruby version in platforms other than MRI/KRI like JRuby or Rubinius.'
  homepage 'https://github.com/tonytonyjan/jaro_winkler'
  version "1.7.1-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '1d86bb6a8682f8d5ddc15546231e56b34b290abcfe5e64dd3f5651062c9ef63d',
     armv7l: '1d86bb6a8682f8d5ddc15546231e56b34b290abcfe5e64dd3f5651062c9ef63d',
       i686: 'd69f5afbfa19437e59bb090160ceaa738152b8a256903fd8360abf5cdcafa0d0',
     x86_64: '0a214c28f6c3c4d68cb165d44083055652c045edae926be52342278ab044299b'
  })

  depends_on 'glibc' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
  upstream_name 'jaro_winkler'
end
