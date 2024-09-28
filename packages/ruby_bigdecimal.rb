require 'buildsystems/ruby'

class Ruby_bigdecimal < RUBY
  description 'This library provides arbitrary-precision decimal floating-point number class.'
  homepage 'https://github.com/ruby/bigdecimal'
  version "3.1.8-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '4aebe17d79164bff3f7473ac196af5d0ce0938c31edecf0f67d4b3b99f6302cc',
     armv7l: '4aebe17d79164bff3f7473ac196af5d0ce0938c31edecf0f67d4b3b99f6302cc',
       i686: 'de1403e68c6841d016daad673eccdde00bed474698224699489cef35c67de518',
     x86_64: '4cb719cc3819e013271a6995f91953f08faa173f628daf0bb56339032207b497'
  })

  conflicts_ok
  gem_compile_needed
end
