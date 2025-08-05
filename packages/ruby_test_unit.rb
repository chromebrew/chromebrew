require 'buildsystems/ruby'

class Ruby_test_unit < RUBY
  description '|- test-unit (test::unit) is unit testing framework for ruby, based on xunit principles.'
  homepage 'https://test-unit.github.io/'
  version "3.7.0-#{CREW_RUBY_VER}"
  license 'PSFL'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_power_assert' # R

  conflicts_ok
  no_compile_needed
end
