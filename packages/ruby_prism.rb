require 'buildsystems/ruby'

class Ruby_prism < RUBY
  description 'Prism is a parser for the Ruby programming language.'
  homepage 'https://github.com/ruby/prism'
  version "1.0.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '7012eb95dbb38f1523a11e8f03f1dccaa433f7fb596f9f83237df7e7ef4d55f9',
     armv7l: '7012eb95dbb38f1523a11e8f03f1dccaa433f7fb596f9f83237df7e7ef4d55f9',
       i686: '82594c8c1a6689f916b6822cd711017a77db118b8f38f12067ddab81d96c6615',
     x86_64: '8ffb949111f9693f83952c74bd69d1fd5bd2e33478f5f722f23aaffb8219cfe9'
  })

  conflicts_ok
  gem_compile_needed
end
