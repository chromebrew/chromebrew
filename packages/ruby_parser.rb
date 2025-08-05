require 'buildsystems/ruby'

class Ruby_parser < RUBY
  description 'A Ruby parser written in pure Ruby.'
  homepage 'https://github.com/whitequark/parser'
  version "3.3.9.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_ast' # R
  depends_on 'ruby_kramdown' # R
  depends_on 'ruby_racc' # R

  conflicts_ok
  no_compile_needed
end
