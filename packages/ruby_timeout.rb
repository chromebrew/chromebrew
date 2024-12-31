require 'buildsystems/ruby'

class Ruby_timeout < RUBY
  description 'Auto-terminate potentially long-running operations in ruby.'
  homepage 'https://github.com/ruby/timeout'
  version "0.4.3-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
