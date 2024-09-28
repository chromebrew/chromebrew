require 'buildsystems/ruby'

class Ruby_tempfile < RUBY
  description 'A utility class for managing temporary files.'
  homepage 'https://github.com/ruby/tempfile'
  version "0.2.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
