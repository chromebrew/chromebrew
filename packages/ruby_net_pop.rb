require 'buildsystems/ruby'

class Ruby_net_pop < RUBY
  description 'Ruby client library for POP3.'
  homepage 'https://github.com/ruby/net-pop'
  version "0.1.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_net_protocol' # R

  conflicts_ok
  no_compile_needed
end
