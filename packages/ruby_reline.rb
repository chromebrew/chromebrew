require 'buildsystems/ruby'

class Ruby_reline < RUBY
  description 'Alternative GNU Readline or Editline implementation by pure Ruby.'
  homepage 'https://github.com/ruby/reline'
  version "0.5.10-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
