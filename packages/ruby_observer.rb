require 'buildsystems/ruby'

class Ruby_observer < RUBY
  description 'Implementation of the observer object-oriented design pattern.'
  homepage 'https://github.com/ruby/observer'
  version "0.1.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
