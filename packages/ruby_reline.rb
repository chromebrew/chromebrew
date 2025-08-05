require 'buildsystems/ruby'

class Ruby_reline < RUBY
  description 'Alternative GNU Readline or Editline implementation by pure Ruby.'
  homepage 'https://github.com/ruby/reline'
  version "0.6.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_io_console' # R

  conflicts_ok
  no_compile_needed
end
