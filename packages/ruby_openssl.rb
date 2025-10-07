require 'buildsystems/ruby'

class Ruby_openssl < RUBY
  description 'Openssl for ruby provides access to ssl/tls and general-purpose cryptography based on the openssl library.'
  homepage 'https://github.com/ruby/openssl'
  version "3.3.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'abf0e552fbd0d9b9912a54f45df642de80536807a5e178ca3a6ca0345e82d64f',
     armv7l: 'abf0e552fbd0d9b9912a54f45df642de80536807a5e178ca3a6ca0345e82d64f',
       i686: 'a34602ef5635703fef1155cf1e1ef3f3680b4bef0555c53f399ce610e541794a',
     x86_64: 'a899294875e4bfe3e9f4bcd11b718525fca60bf03435acca63ed79279a5e6230'
  })

  conflicts_ok
  gem_compile_needed
end
