require 'buildsystems/ruby'

class Ruby_irb < RUBY
  description 'Interactive Ruby command-line tool for REPL (Read Eval Print Loop).'
  homepage 'https://github.com/ruby/irb'
  version "1.14.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
