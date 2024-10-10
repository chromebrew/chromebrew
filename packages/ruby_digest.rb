require 'buildsystems/ruby'

class Ruby_digest < RUBY
  description 'Provides a framework for message digest libraries.'
  homepage 'https://github.com/ruby/digest'
  version "3.1.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
