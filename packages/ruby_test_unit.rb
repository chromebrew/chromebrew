require 'buildsystems/ruby'

class Ruby_test_unit < RUBY
  description 'test-unit (Test::Unit) is unit testing framework for Ruby, based on xUnit principles.'
  homepage 'http://test-unit.github.io/'
  version "3.6.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
