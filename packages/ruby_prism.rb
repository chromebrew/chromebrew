require 'buildsystems/ruby'

class Ruby_prism < RUBY
  description 'Prism is a parser for the Ruby programming language.'
  homepage 'https://github.com/ruby/prism'
  version "2.1.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'f60d90f4930e3d2d53d6d8a3bc1fb7bba6b63a7ad4eb4016864231bfcccc55fd',
     armv7l: 'f60d90f4930e3d2d53d6d8a3bc1fb7bba6b63a7ad4eb4016864231bfcccc55fd',
       i686: 'cea7dda1fe02c920b3ca7fcf1b41ee22db7da99ab7797aa98ecd412293a2896c',
     x86_64: '2ad152bde626ad9f9f0687bc6464e1c42d914ea7051306270b367fb839069cf4'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
