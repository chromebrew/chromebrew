require 'buildsystems/ruby'

class Ruby_open3 < RUBY
  description 'Popen, but with stderr, too.'
  homepage 'https://github.com/ruby/open3'
  version "0.2.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
