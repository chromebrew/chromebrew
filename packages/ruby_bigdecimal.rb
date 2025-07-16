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
       i686: 'a216725e25a38a0eb03446137d0c660a912cc54b099d22f7fd706e4564b20413',
     x86_64: '3d6a052a3a09e584d55fa12f4c9f4f71250ced05830fdccc430dbdf3cd5518dc'
  })

  conflicts_ok
  gem_compile_needed
end
