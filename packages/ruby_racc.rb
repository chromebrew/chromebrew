require 'buildsystems/ruby'

class Ruby_racc < RUBY
  description 'Racc is a LALR(1) parser generator.'
  homepage 'https://github.com/ruby/racc'
  version "1.8.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  gem_compile_needed
  no_source_build
end
