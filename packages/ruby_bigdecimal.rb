require 'buildsystems/ruby'

class Ruby_bigdecimal < RUBY
  description 'This library provides arbitrary-precision decimal floating-point number class.'
  homepage 'https://github.com/ruby/bigdecimal'
  version "4.1.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '2611dbe83518399e890666215b07341f24c94d653ffae9d309f034fb0221f326',
     armv7l: '2611dbe83518399e890666215b07341f24c94d653ffae9d309f034fb0221f326',
       i686: 'cf1d5a79bdf0efcbd6b857c879e920bc0edbcce455b8027f25f7a47fe4f94960',
     x86_64: '85578386735a15f23d0040f3cbb3761890119bb3c414810fad3d57866ed49ead'
  })

  depends_on 'glibc' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
