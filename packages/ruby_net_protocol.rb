require 'buildsystems/ruby'

class Ruby_net_protocol < RUBY
  description 'The abstract interface for net-* client.'
  homepage 'https://github.com/ruby/net-protocol'
  version "0.2.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_timeout' # R

  conflicts_ok
  no_compile_needed
end
