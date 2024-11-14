require 'buildsystems/ruby'

class Ruby_tsort < RUBY
  description "Topological sorting using tarjan's algorithm."
  homepage 'https://github.com/ruby/tsort'
  version "0.2.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
