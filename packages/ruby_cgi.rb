require 'buildsystems/ruby'

class Ruby_cgi < RUBY
  description 'Support for the common gateway interface protocol.'
  homepage 'https://github.com/ruby/cgi'
  version "0.5.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '638200863fc3f23003e62cfd66d5d141fe46669bcde9766f5e147d59e16a0ce0',
     armv7l: '638200863fc3f23003e62cfd66d5d141fe46669bcde9766f5e147d59e16a0ce0',
       i686: '6526f8417c3820f657b82e81696c9bf49285325abac8cf6bcbed35b6c8e3e6b1',
     x86_64: '5fdfffc4229cebfca3f283abf42e43371a4a0f2c1567dc4a3d3067e5ce45a959'
  })

  conflicts_ok
  gem_compile_needed
end
