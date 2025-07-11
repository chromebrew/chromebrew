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
    aarch64: '05f7c1b496933738df9137d832add02f3dc410ccef7aa0a791556cc92104e9d5',
     armv7l: '05f7c1b496933738df9137d832add02f3dc410ccef7aa0a791556cc92104e9d5',
       i686: 'ec1d546a2e400b713cbfb3765a5e640d39f44c6a621ed39993c4ce7601a2e698',
     x86_64: '8d6074bb8df8d1239230b9b6f118e99e1419c23d9fb13352cb9ceef73d057654'
  })

  conflicts_ok
  gem_compile_needed
end
