require 'buildsystems/ruby'

class Ruby_bigdecimal < RUBY
  description 'This library provides arbitrary-precision decimal floating-point number class.'
  homepage 'https://github.com/ruby/bigdecimal'
  version "4.0.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'a0142f9b1c8c22914cd3e3b427d6a6d7b374c00431a871553af9e5b8b13fd23d',
     armv7l: 'a0142f9b1c8c22914cd3e3b427d6a6d7b374c00431a871553af9e5b8b13fd23d',
       i686: 'a2109a1ad63de6531769d3a8cabf872d3c6412cc6a4db36443712d4156d46b00',
     x86_64: '12382bb49f57dcf639863f9639dfc55518c7de70cc014ab54213d37a5bfbdcaa'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
