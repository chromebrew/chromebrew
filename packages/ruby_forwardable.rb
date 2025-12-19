require 'buildsystems/ruby'

class Ruby_forwardable < RUBY
  description 'Provides delegation of specified methods to a designated object.'
  homepage 'https://github.com/ruby/forwardable'
  version "1.4.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
