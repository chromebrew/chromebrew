require 'buildsystems/ruby'

class Ruby_rubocop_ast < RUBY
  description "Contains the classes needed by RuboCop to deal with Ruby's AST."
  homepage 'https://github.com/rubocop/rubocop-ast'
  version "1.44.1-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_parser' # R

  conflicts_ok
  no_compile_needed
end
