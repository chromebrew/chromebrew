require 'buildsystems/ruby'

class Ruby_bigdecimal < RUBY
  description 'This library provides arbitrary-precision decimal floating-point number class.'
  homepage 'https://github.com/ruby/bigdecimal'
  version "4.1.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '5758d382a402e76ce5e4d6fd302a8223e12017beea579c80ac9c17c0d70cf20b',
     armv7l: '5758d382a402e76ce5e4d6fd302a8223e12017beea579c80ac9c17c0d70cf20b',
       i686: '38946cfbbe11bbfcb8f68b0696b0c52f3be37a11d4117595b910cf86004a834e',
     x86_64: 'f34f5e3f3c9eb17c6dc2924fa70a2284a52e386fbc63ff2710e496184625aeed'
  })

  depends_on 'glibc' => :library
  depends_on 'ruby' => :library
  depends_on 'ruby' => :logical

  conflicts_ok
  gem_compile_needed
end
