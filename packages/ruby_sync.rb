require 'buildsystems/ruby'

class Ruby_sync < RUBY
  description 'A module that provides a two-phase lock with a counter.'
  homepage 'https://github.com/ruby/sync'
  version "0.5.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
