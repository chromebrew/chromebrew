require 'buildsystems/ruby'

class Ruby_ipaddr < RUBY
  description '| ipaddr provides a set of methods to manipulate an ip address.'
  homepage 'https://github.com/ruby/ipaddr'
  version "1.2.7-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
