require 'buildsystems/ruby'

class Ruby_parallel < RUBY
  description 'Run any code in parallel Processes(> use all CPUs), Threads(> speedup blocking operations), or Ractors(> use all CPUs).'
  homepage 'https://github.com/grosser/parallel'
  version "1.27.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
