require 'buildsystems/ruby'

class Ruby_digest < RUBY
  description 'Provides a framework for message digest libraries.'
  homepage 'https://github.com/ruby/digest'
  version "3.2.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '2bf0e552fbd0d9b9912a54f45df642de80536807a5e178ca3a6ca0345e82d64f',
     armv7l: '2bf0e552fbd0d9b9912a54f45df642de80536807a5e178ca3a6ca0345e82d64f',
       i686: '934602ef5635703fef1155cf1e1ef3f3680b4bef0555c53f399ce610e541794a',
     x86_64: '7899294875e4bfe3e9f4bcd11b718525fca60bf03435acca63ed79279a5e6230'
  })

  conflicts_ok
  gem_compile_needed
end
