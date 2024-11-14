require 'buildsystems/ruby'

class Ruby_find < RUBY
  description 'This module supports top-down traversal of a set of file paths.'
  homepage 'https://github.com/ruby/find'
  version "0.2.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
