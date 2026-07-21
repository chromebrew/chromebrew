require 'buildsystems/ruby'

class Ruby_erb < RUBY
  description 'An easy to use but powerful templating system for Ruby.'
  homepage 'https://github.com/ruby/erb'
  version "6.0.6-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'f2074932e330c8888e3c399eebd03765354b4a85ef7a1b7313241d4b28787e3a',
     armv7l: 'f2074932e330c8888e3c399eebd03765354b4a85ef7a1b7313241d4b28787e3a',
       i686: 'e0c38c2c053d7e1c876864df0b7e8a146ac41ab81cf4a2dbb4d6d637d59554c6',
     x86_64: 'd8df0a1aba29665a5e181cc6d336e3e6d470045ab8dc386a51be4bc96d68b321'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library
  depends_on 'ruby_cgi' # R

  conflicts_ok
  gem_compile_needed
end
