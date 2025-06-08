require 'buildsystems/ruby'

class Ruby_prism < RUBY
  description 'Prism is a parser for the Ruby programming language.'
  homepage 'https://github.com/ruby/prism'
  version "1.4.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'd908e2c934963e6bcf6a1e5d5ca1acdfe4fd0b435b8cc6d748e0a92195d31bb6',
     armv7l: 'd908e2c934963e6bcf6a1e5d5ca1acdfe4fd0b435b8cc6d748e0a92195d31bb6',
       i686: '5056af7b2af7f10a743d1d3c884d39f9e1b860892096f2cb9c94277b888843f8',
     x86_64: 'e93b758028a8f31a3d3ff02ee099cb4da57ba1ca03805e12cbde8b16b4ac21fb'
  })

  conflicts_ok
  gem_compile_needed
end
