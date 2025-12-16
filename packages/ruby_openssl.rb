require 'buildsystems/ruby'

class Ruby_openssl < RUBY
  description 'Openssl for ruby provides access to ssl/tls and general-purpose cryptography based on the openssl library.'
  homepage 'https://github.com/ruby/openssl'
  version "4.0.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'dbf0b092f6fbb2940d6d32f8437157c927ddd3f36b8e3c2fe83c3264b398b98a',
     armv7l: 'dbf0b092f6fbb2940d6d32f8437157c927ddd3f36b8e3c2fe83c3264b398b98a',
       i686: '21dcf42557b53181d794ebeeefbee44726ad032dd1ff3f6c99df91d043f60e17',
     x86_64: '136373d545fba2460841da43016ccc801836eb2d7bbe565b064c5622f3e1bf5a'
  })

  conflicts_ok
  gem_compile_needed
end
