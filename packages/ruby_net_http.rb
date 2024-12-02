require 'buildsystems/ruby'

class Ruby_net_http < RUBY
  description 'Http client api for ruby.'
  homepage 'https://github.com/ruby/net-http'
  version "0.5.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_uri' # R

  conflicts_ok
  no_compile_needed
end
