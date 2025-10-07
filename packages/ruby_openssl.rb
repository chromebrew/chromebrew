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
       i686: '628704dbc75ae704c28d2cb0c19edeb06179b036f8d0cfa1a8dde580b7a461ec',
     x86_64: 'b25dc0cee0c2f28afdbe95a9976bfc63e31edbfe5a25d3be90de781bb0cddbb7'
  })

  conflicts_ok
  gem_compile_needed
end
