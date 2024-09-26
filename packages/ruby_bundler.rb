require 'buildsystems/ruby'

class Ruby_bundler < RUBY
  description 'many machines, systematically and repeatably.'
  homepage 'https://bundler.io'
  version "2.5.20-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
