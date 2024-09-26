require 'buildsystems/ruby'

class Ruby_net_smtp < RUBY
  description 'Simple Mail Transfer Protocol client library for Ruby.'
  homepage 'https://github.com/ruby/net-smtp'
  version "0.5.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
