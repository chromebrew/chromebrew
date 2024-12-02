require 'buildsystems/ruby'

class Ruby_fileutils < RUBY
  description 'Several file utility methods for copying, moving, removing, etc.'
  homepage 'https://github.com/ruby/fileutils'
  version "1.7.3-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
