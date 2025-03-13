require 'buildsystems/ruby'

class Ruby_minitest < RUBY
  description 'minitest provides a complete suite of testing facilities supporting TDD, BDD, mocking, and benchmarking.'
  homepage 'https://github.com/minitest/minitest'
  version "5.25.5-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
