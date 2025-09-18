require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.14.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '97e90c52c9ebfe63fb262d447c1d6aef7e2b81f41924f77b88d01631213490f4',
     armv7l: '97e90c52c9ebfe63fb262d447c1d6aef7e2b81f41924f77b88d01631213490f4',
       i686: 'e6f0ff648c14a50f690f5d7442112decf9e25aa4d9bfcbd89a1e8a3a68a75cbf',
     x86_64: 'f9899c335d6060fe45c13819fcf7d7c77a22c9cf5ecc3d15ad9650788daf76ce'
  })

  conflicts_ok
  gem_compile_needed
end
