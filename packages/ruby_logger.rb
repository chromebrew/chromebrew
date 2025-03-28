require 'buildsystems/ruby'

class Ruby_logger < RUBY
  description 'Provides a simple logging utility for outputting messages.'
  homepage 'https://github.com/ruby/logger'
  version "1.7.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
