require 'buildsystems/ruby'

class Ruby_thor < RUBY
  description 'Thor is a toolkit for building powerful command-line interfaces.'
  homepage 'http://whatisthor.com/'
  version "1.4.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
