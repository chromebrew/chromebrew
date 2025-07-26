require 'buildsystems/ruby'

class Ruby_yard_solargraph < RUBY
  description 'A YARD extension for documenting Solargraph tags.'
  homepage 'https://solargraph.org'
  version "0.1.0-#{CREW_RUBY_VER}"
  license '---'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_yard' # R

  conflicts_ok
  no_compile_needed
end
