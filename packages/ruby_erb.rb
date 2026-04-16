require 'buildsystems/ruby'

class Ruby_erb < RUBY
  description 'An easy to use but powerful templating system for Ruby.'
  homepage 'https://github.com/ruby/erb'
  version "6.0.3-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'bf12aaf4070bab45f0a8eb37559f3ba377bfbe676baf99c9ebc0ab0708b33f30',
     armv7l: 'bf12aaf4070bab45f0a8eb37559f3ba377bfbe676baf99c9ebc0ab0708b33f30',
       i686: '420029e2d68993cf8a01384c27657451dc6c973824e803ea401512634e13e0b7',
     x86_64: 'f31806160064ce1118e5b8417e49c143956685b041cab89dd68173efb632e7ec'
  })

  depends_on 'glibc' => :library
  depends_on 'ruby' => :library
  depends_on 'ruby_cgi' # R

  conflicts_ok
  gem_compile_needed
end
