require 'buildsystems/ruby'

class Ruby_repl_type_completor < RUBY
  description 'Type based completion for REPL.'
  homepage 'https://github.com/ruby/repl_type_completor'
  version "0.1.11-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_prism' # R
  depends_on 'ruby_rbs' # R

  conflicts_ok
  no_compile_needed
end
