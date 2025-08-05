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
    aarch64: 'b6929d5e5fbcf9acd9524340a4798801e0681c37a005c1033d31203cb7964753',
     armv7l: 'b6929d5e5fbcf9acd9524340a4798801e0681c37a005c1033d31203cb7964753',
       i686: 'ef1404cf0adc1eab2c1f0fa9e51b3ca7d93beb748bab9148c20e3b6a22c85b14',
     x86_64: '5fdfffc4229cebfca3f283abf42e43371a4a0f2c1567dc4a3d3067e5ce45a959'
  })

  conflicts_ok
  gem_compile_needed
end
