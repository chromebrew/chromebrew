require 'buildsystems/ruby'

class Ruby_io_console < RUBY
  description 'add console capabilities to IO instances.'
  homepage 'https://github.com/ruby/io-console'
  version "0.9.2-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'e6001cf193ce6940f26b5c347b34abb918e7678fc775bb727ff0a3777a9bd5c5',
     armv7l: 'e6001cf193ce6940f26b5c347b34abb918e7678fc775bb727ff0a3777a9bd5c5',
       i686: '7789938378b2a8d62b887f4e10c7c28ffa0d95cba5279fd5d141ad6023dd5860',
     x86_64: '244853423e96b762b120ff88b9243117021be89dae61b2e795dbdbf0b1f8a93b'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
