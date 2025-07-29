require 'buildsystems/ruby'

class Ruby_tilt < RUBY
  description 'Generic interface to multiple Ruby template engines.'
  homepage 'https://github.com/jeremyevans/tilt'
  version "2.6.1-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
