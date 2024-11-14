require 'buildsystems/ruby'

class Ruby_tracer < RUBY
  description 'A Ruby tracer.'
  homepage 'https://github.com/ruby/tracer'
  version "0.2.3-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
