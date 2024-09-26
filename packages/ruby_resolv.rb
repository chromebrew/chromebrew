require 'buildsystems/ruby'

class Ruby_resolv < RUBY
  description 'Thread-aware DNS resolver library in Ruby.'
  homepage 'https://github.com/ruby/resolv'
  version "0.4.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
