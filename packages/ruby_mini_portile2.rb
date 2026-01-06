require 'buildsystems/ruby'

class Ruby_mini_portile2 < RUBY
  description 'Simple autoconf and cmake builder for developers.'
  homepage 'https://github.com/flavorjones/mini_portile'
  version "2.8.9-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  conflicts_ok
  gem_compile_needed
end
