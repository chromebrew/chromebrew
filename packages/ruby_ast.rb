require 'buildsystems/ruby'

class Ruby_ast < RUBY
  description 'A library for working with Abstract Syntax Trees.'
  homepage 'https://whitequark.github.io/ast/'
  version "2.4.2-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_parser' # R

  conflicts_ok
  no_compile_needed
end
