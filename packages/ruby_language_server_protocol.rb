require 'buildsystems/ruby'

class Ruby_language_server_protocol < RUBY
  description 'A Language Server Protocol SDK.'
  homepage 'https://github.com/mtsmfm/language_server-protocol-ruby'
  version "3.17.0.4-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
