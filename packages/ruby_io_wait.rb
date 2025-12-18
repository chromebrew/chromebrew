require 'buildsystems/ruby'

class Ruby_io_wait < RUBY
  description 'Waits until io is readable or writable without blocking.'
  homepage 'https://github.com/ruby/io-wait'
  version "0.4.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '4f6024ca91fc94cd44d4e84a090d9f4e355b76d04d5ecd0bf8dc5f16517cb638',
     armv7l: '4f6024ca91fc94cd44d4e84a090d9f4e355b76d04d5ecd0bf8dc5f16517cb638',
       i686: '81abf826342342e839b2435d262d3b6dc3434d16ddca61263e5f26564fb15b33',
     x86_64: '8f69c1856f0249eb9d9e5a815df91d1c2975dafefc835bf76bac536162e6431a'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
