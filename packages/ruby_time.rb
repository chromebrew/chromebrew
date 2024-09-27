require 'buildsystems/ruby'

class Ruby_time < RUBY
  description 'Extends the Time class with methods for parsing and conversion.'
  homepage 'https://github.com/ruby/time'
  version "0.4.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
