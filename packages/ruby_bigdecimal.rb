require 'buildsystems/ruby'

class Ruby_bigdecimal < RUBY
  description 'This library provides arbitrary-precision decimal floating-point number class.'
  homepage 'https://github.com/ruby/bigdecimal'
  version "4.1.2-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '057c2b8b5279b82093853fdc937dcf9b24434c0f0610de1506db90e2a5910095',
     armv7l: '057c2b8b5279b82093853fdc937dcf9b24434c0f0610de1506db90e2a5910095',
       i686: '7e8758fb60010c8c1be2748e83c9a20acccd86e64efba9f6363dd48aebd97bf4',
     x86_64: '0f2bf713d0fdc3281a1b8f5eb868f91538f9a50129fa4e5b15094167c315760b'
  })

  depends_on 'glibc' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
