require 'buildsystems/ruby'

class Ruby_benchmark < RUBY
  description 'A performance benchmarking library.'
  homepage 'https://github.com/ruby/benchmark'
  version "0.4.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
