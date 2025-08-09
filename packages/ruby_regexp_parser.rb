require 'buildsystems/ruby'

class Ruby_regexp_parser < RUBY
  description 'A library for tokenizing, lexing, and parsing Ruby regular expressions.'
  homepage 'https://github.com/ammar/regexp_parser'
  version "2.11.1-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
