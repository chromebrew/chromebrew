require 'buildsystems/ruby'

class Ruby_irb < RUBY
  description 'Interactive Ruby command-line tool for REPL (Read Eval Print Loop).'
  homepage 'https://github.com/ruby/irb'
  version "1.15.2-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_rdoc' # R
  depends_on 'ruby_reline' # R

  conflicts_ok
  no_compile_needed
end
