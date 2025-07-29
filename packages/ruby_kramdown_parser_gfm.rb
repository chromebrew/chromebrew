require 'buildsystems/ruby'

class Ruby_kramdown_parser_gfm < RUBY
  description 'Kramdown-parser-gfm provides a kramdown parser for the GFM dialect of Markdown'
  homepage 'https://github.com/kramdown/parser-gfm'
  version "1.1.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_kramdown' # R

  conflicts_ok
  no_compile_needed
end
