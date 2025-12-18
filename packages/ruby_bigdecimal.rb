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
    aarch64: '49c4408aed29ffaf450f06f9d5753b0ac34b070501361a37b53c8aa9230f48c2',
     armv7l: '49c4408aed29ffaf450f06f9d5753b0ac34b070501361a37b53c8aa9230f48c2',
       i686: '659022d33282cfa1dd06d99e85e2a4b3c0e871634419f5a3358b0f198d9b24dc',
     x86_64: 'f5f8babaa4672f4c1364807482ad38f982ba7ed68247527cb8af39997ad18598'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
