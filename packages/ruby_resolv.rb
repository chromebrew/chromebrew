require 'buildsystems/ruby'

class Ruby_resolv < RUBY
  description 'Thread-aware dns resolver library in ruby.'
  homepage 'https://github.com/ruby/resolv'
  version "0.6.2-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '12a1218aa609dec6d3224a70bec81048df66f7904dd8669e6a821812958ab1f7',
     armv7l: '12a1218aa609dec6d3224a70bec81048df66f7904dd8669e6a821812958ab1f7',
       i686: 'ec1d546a2e400b713cbfb3765a5e640d39f44c6a621ed39993c4ce7601a2e698',
     x86_64: '8d6074bb8df8d1239230b9b6f118e99e1419c23d9fb13352cb9ceef73d057654'
  })

  conflicts_ok
  gem_compile_needed
end
