require 'buildsystems/ruby'

class Ruby_delegate < RUBY
  description 'Provides three abilities to delegate method calls to an object.'
  homepage 'https://github.com/ruby/delegate'
  version "0.3.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
