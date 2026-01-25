require 'buildsystems/ruby'

class Ruby_dagwood < RUBY
  description 'Dagwood allows you to create dependency graphs for doing work in series or in parallel, always in the right order.'
  homepage 'https://github.com/rewindio/dagwood'
  version "1.0.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
