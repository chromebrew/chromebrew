require 'buildsystems/ruby'

class Ruby_date < RUBY
  description 'A subclass of object includes comparable module for handling dates.'
  homepage 'https://github.com/ruby/date'
  version "3.4.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
