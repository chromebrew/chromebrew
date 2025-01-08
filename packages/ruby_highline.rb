require 'buildsystems/ruby'

class Ruby_highline < RUBY
  description 'A higher level command-line oriented interface.'
  homepage 'https://github.com/JEG2/highline'
  version "3.1.2-#{CREW_RUBY_VER}"
  license 'GPL'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
