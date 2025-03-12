require 'buildsystems/ruby'

class Ruby_rainbow < RUBY
  description 'Colorize printed text on ANSI terminals.'
  homepage 'https://github.com/sickill/rainbow'
  version "3.1.1-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
