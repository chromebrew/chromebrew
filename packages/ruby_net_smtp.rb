require 'buildsystems/ruby'

class Ruby_net_smtp < RUBY
  description 'Simple Mail Transfer Protocol client library for Ruby.'
  homepage 'https://github.com/ruby/net-smtp'
  version "0.5.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
