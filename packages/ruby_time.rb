require 'buildsystems/ruby'

class Ruby_time < RUBY
  description 'Extends the time class with methods for parsing and conversion.'
  homepage 'https://github.com/ruby/time'
  version "0.4.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_date' # R

  conflicts_ok
  no_compile_needed
end
