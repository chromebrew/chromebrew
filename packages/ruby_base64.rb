require 'buildsystems/ruby'

class Ruby_base64 < RUBY
  description 'Support for encoding and decoding binary data using a base64 representation.'
  homepage 'https://github.com/ruby/base64'
  version "0.3.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
