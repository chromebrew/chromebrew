require 'buildsystems/ruby'

class Ruby_cgi < RUBY
  description 'Support for the common gateway interface protocol.'
  homepage 'https://github.com/ruby/cgi'
  version "0.4.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
