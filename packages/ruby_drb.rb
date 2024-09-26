require 'buildsystems/ruby'

class Ruby_drb < RUBY
  description 'Distributed object system for Ruby'
  homepage 'https://github.com/ruby/drb'
  version "2.2.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
