require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "3.1.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '10607fb2b26005bd483f83e7c2b3aa86a6e8c3abaa7c2e2f5ee17d8fd4bb54aa',
     armv7l: '10607fb2b26005bd483f83e7c2b3aa86a6e8c3abaa7c2e2f5ee17d8fd4bb54aa',
       i686: 'bc46f96e2ffd6affe7a64c0e98e400e6a1bfdd0025a3347a5aebeea505359b6d',
     x86_64: 'b1d76e8f521ac95aab22de69e85d2e5995fe0bf6c046e691bbff5f46ed54fa0d'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
