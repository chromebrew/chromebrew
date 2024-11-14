require 'buildsystems/ruby'

class Ruby_scanf < RUBY
  description 'scanf is an implementation of the C function scanf(3).'
  homepage 'https://github.com/ruby/scanf'
  version "1.0.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
