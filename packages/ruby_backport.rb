require 'buildsystems/ruby'

class Ruby_backport < RUBY
  description 'A pure Ruby library for event-driven IO.'
  homepage 'http://github.com/castwide/backport'
  version "1.2.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
