require 'buildsystems/ruby'

class Ruby_digest < RUBY
  description 'Provides a framework for message digest libraries.'
  homepage 'https://github.com/ruby/digest'
  version "3.2.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'bd84f978b0a01e6ca2a3bc0b70630abbfcf4495f92ee4c3fe3b20c8c446d7ed3',
     armv7l: 'bd84f978b0a01e6ca2a3bc0b70630abbfcf4495f92ee4c3fe3b20c8c446d7ed3',
       i686: 'e91a7d6f7f2121bcb81144056c3ececf25b934e70137dbbddb6ac2dd9fa19dfb',
     x86_64: '1174e436f7c2b41f44e85cd1b521be28d399e8a58c36593c2e1137b5b3f26925'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
