require 'buildsystems/ruby'

class Ruby_bigdecimal < RUBY
  description 'This library provides arbitrary-precision decimal floating-point number class.'
  homepage 'https://github.com/ruby/bigdecimal'
  version "4.0.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '98c81bad6b853b2b07b6e5e00f4e3edfcb6ef622d3034bd7cf4c64725c4ff824',
     armv7l: '98c81bad6b853b2b07b6e5e00f4e3edfcb6ef622d3034bd7cf4c64725c4ff824',
       i686: '84495b4d2a476ef7c81c6ca0fdbbd2c59e2b913fd7807ab3d0c7addf27aecf1f',
     x86_64: '3159c9871e9827f8322473fa615f0080b64d311a7b7a4bc77e118077c433c096'
  })

  conflicts_ok
  gem_compile_needed
end
