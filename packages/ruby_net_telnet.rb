require 'buildsystems/ruby'

class Ruby_net_telnet < RUBY
  description 'Provides telnet client functionality.'
  homepage 'https://github.com/ruby/net-telnet'
  version "0.2.0-#{CREW_RUBY_VER}"
  license 'ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
