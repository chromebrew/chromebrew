require 'buildsystems/ruby'

class Ruby_power_assert < RUBY
  description 'Power assert shows each value of variables and method calls in the expression.'
  homepage 'https://github.com/ruby/power_assert'
  version "2.0.4-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
