require 'buildsystems/ruby'

class Ruby_json < RUBY
  description 'This is a JSON implementation as a Ruby extension in C.'
  homepage 'https://flori.github.io/json'
  version "2.13.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'a097032c47068fd1d2be644ba73d4088ec838fcf85b04aa4f538363c6d7bb64d',
     armv7l: 'a097032c47068fd1d2be644ba73d4088ec838fcf85b04aa4f538363c6d7bb64d',
       i686: '1a0fca8623424a290da7221e2aed57c45132d5be82be76cfb1de9b73cebf6368',
     x86_64: 'd29eb0ac6a8dfe22805295349767f321d37531e178e97a342ad5dabcf03d855c'
  })

  conflicts_ok
  gem_compile_needed
end
