require 'buildsystems/ruby'

class Ruby_prettyprint < RUBY
  description 'Implements a pretty printing algorithm for readable structure.'
  homepage 'https://github.com/ruby/prettyprint'
  version "0.2.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
