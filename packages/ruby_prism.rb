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
    aarch64: '48909ecefd938e8edf1a30b943c084889c8d7b400362306097086f80a3611cfb',
     armv7l: '48909ecefd938e8edf1a30b943c084889c8d7b400362306097086f80a3611cfb',
       i686: '5bc72b925fc80b02119b38b6a59958a5de2d947bd2b34901ec67893168721016',
     x86_64: 'c9d4145ad001d4809e24cdf063ddd8c7071ac0cd8e070c3c7a7ba0bfbe6aef84'
  })

  conflicts_ok
  gem_compile_needed
end
