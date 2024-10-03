require 'buildsystems/ruby'

class Ruby_prism < RUBY
  description 'Prism is a parser for the Ruby programming language.'
  homepage 'https://github.com/ruby/prism'
  version "1.1.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'f3fc461907d1b6bf04fdecee551977d22c24db19e04ee599a9178372664ce566',
     armv7l: 'f3fc461907d1b6bf04fdecee551977d22c24db19e04ee599a9178372664ce566',
       i686: '94af15e78336e33d1cd45a61c9161c6b13e09dd6dd93d372841cfa5f7f7fc3ad',
     x86_64: '05e12c8d2284910227229a3257aec37212e31f7c6afc83d9bf3aa677b6fb76b7'
  })

  conflicts_ok
  gem_compile_needed
end
