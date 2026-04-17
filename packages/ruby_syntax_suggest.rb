require 'buildsystems/ruby'

class Ruby_syntax_suggest < RUBY
  description "When you get an 'unexpected end' in your syntax this gem helps you find it."
  homepage 'https://github.com/ruby/syntax_suggest.git'
  version "3.0.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
  upstream_name 'syntax_suggest'
end
