require 'buildsystems/ruby'

class Ruby_securerandom < RUBY
  description 'Interface for secure random number generator.'
  homepage 'https://github.com/ruby/securerandom'
  version "0.3.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
