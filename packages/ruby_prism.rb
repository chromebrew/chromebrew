require 'buildsystems/ruby'

class Ruby_prism < RUBY
  description 'Prism is a parser for the Ruby programming language.'
  homepage 'https://github.com/ruby/prism'
  version "1.5.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'c4d09aa98c508100a6812ccd498f4a16bc2d03719ce600516ec5b987c4497b57',
     armv7l: 'c4d09aa98c508100a6812ccd498f4a16bc2d03719ce600516ec5b987c4497b57',
       i686: '3e93a7123018b0a90346410092c9276e2c073ce128c8c1e26cc816ba0deec6b1',
     x86_64: '983e0aae35c3340e764b86efd19650e5612fac86b4d5d0c76f45c64cafe33ba5'
  })

  conflicts_ok
  gem_compile_needed
end
