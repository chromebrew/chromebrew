require 'buildsystems/ruby'

class Ruby_openssl < RUBY
  description 'Openssl for ruby provides access to ssl/tls and general-purpose cryptography based on the openssl library.'
  homepage 'https://github.com/ruby/openssl'
  version "3.2.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
