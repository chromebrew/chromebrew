require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "3.2.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '7890027a33fa0caf62a4db09d08ab562869a242af6bcb53437d51cadb9b27438',
     armv7l: '7890027a33fa0caf62a4db09d08ab562869a242af6bcb53437d51cadb9b27438',
       i686: 'f31148b0e2bdebd5f9edaa6dfab20d60db0f5180d11d5ce82d7ebbdf0fddd464',
     x86_64: '1e63be8a305ab16b04ab816da664109f77346fa49096bdb3a0eeb3863e999594'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
