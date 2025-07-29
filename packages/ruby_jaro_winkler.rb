require 'buildsystems/ruby'

class Ruby_jaro_winkler < RUBY
  description 'Jaro_winkler is an implementation of Jaro-Winkler distance algorithm which is written in C extension and will fallback to pure Ruby version in platforms other than MRI/KRI like JRuby or Rubinius.'
  homepage 'https://github.com/tonytonyjan/jaro_winkler'
  version "1.6.1-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '344eabc608f000461c619e010ab1b4f0f88a0c3ed8308482f5747a00d0db01a2',
     armv7l: '344eabc608f000461c619e010ab1b4f0f88a0c3ed8308482f5747a00d0db01a2',
       i686: '13b35612d15b4fa1cdef5587937694a12ea99f7955f280f8e822a89bb3b5d048',
     x86_64: 'fe2ca60b456afb8f32510f71cf55213b8e6774495c82bfbf5a4380b6a0bc2ab0'
  })

  conflicts_ok
  gem_compile_needed
end
