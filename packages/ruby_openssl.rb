require 'buildsystems/ruby'

class Ruby_openssl < RUBY
  description 'Openssl for ruby provides access to ssl/tls and general-purpose cryptography based on the openssl library.'
  homepage 'https://github.com/ruby/openssl'
  version "4.0.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '164904f6486e02dc1561b2d0f166ad9205898c9faab0d70a4582385acf7a33db',
     armv7l: '164904f6486e02dc1561b2d0f166ad9205898c9faab0d70a4582385acf7a33db',
       i686: '8d5507e28649f494b0daf3a97690dae84165836015dc3a766b4548c86f85107c',
     x86_64: '4f12e0815f7768dd533f3ccd009533d0698759724c032095c85b5c961d8b1fc2'
  })

  depends_on 'glibc' # R
  depends_on 'openssl' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
