require 'buildsystems/ruby'

class Ruby_bigdecimal < RUBY
  description 'This library provides arbitrary-precision decimal floating-point number class.'
  homepage 'https://github.com/ruby/bigdecimal'
  version "3.2.2-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'b0d23dfb1d20da3bb43b0be1e48c1ef73e2017aee6dbabd3de6b72e88bec8f23',
     armv7l: 'b0d23dfb1d20da3bb43b0be1e48c1ef73e2017aee6dbabd3de6b72e88bec8f23',
       i686: '97d40beb3af93e11cfe2bd5f3d2ca7faedaf61a6f50ef88a4edc2d6762673068',
     x86_64: '194605ae2247af5799cdd70c521d207fb63a0da72a623cfeb5070309e1e9e06d'
  })

  conflicts_ok
  gem_compile_needed
end
