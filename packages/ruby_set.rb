require 'buildsystems/ruby'

class Ruby_set < RUBY
  description 'Provides a class to deal with collections of unordered, unique values.'
  homepage 'https://github.com/ruby/set'
  version "1.1.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
