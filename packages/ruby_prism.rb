require 'buildsystems/ruby'

class Ruby_prism < RUBY
  description 'Prism is a parser for the Ruby programming language.'
  homepage 'https://github.com/ruby/prism'
  version "1.2.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'bffa8b1d4eee87a87c4573a8be2e4d2a5f779192bbb7e2fcf67a61decda7e64c',
     armv7l: 'bffa8b1d4eee87a87c4573a8be2e4d2a5f779192bbb7e2fcf67a61decda7e64c',
       i686: 'c3193648ed769005feb82416aa8051b20851dcc5451e0cf7e383c77502997faf',
     x86_64: 'e96a488132112a2137ee49647fca18d571a231018ffa8215c4e03657a5295cb2'
  })

  conflicts_ok
  gem_compile_needed
end
