require 'buildsystems/ruby'

class Ruby_mini_portile2 < RUBY
  description 'Simple autoconf and cmake builder for developers.'
  homepage 'https://github.com/flavorjones/mini_portile'
  version "2.8.9-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
