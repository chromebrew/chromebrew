require 'buildsystems/ruby'

class Ruby_singleton < RUBY
  description 'The singleton module implements the singleton pattern.'
  homepage 'https://github.com/ruby/singleton'
  version "0.3.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
