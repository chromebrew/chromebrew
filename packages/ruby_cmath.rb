require 'buildsystems/ruby'

class Ruby_cmath < RUBY
  description 'CMath is a library that provides trigonometric and transcendental functions for complex numbers.'
  homepage 'https://github.com/ruby/cmath'
  version "1.0.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
