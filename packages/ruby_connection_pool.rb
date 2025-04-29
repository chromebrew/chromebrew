require 'buildsystems/ruby'

class Ruby_connection_pool < RUBY
  description 'Generic connection pool for ruby.'
  homepage 'https://github.com/mperham/connection_pool'
  version "2.5.3-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
