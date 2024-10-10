require 'buildsystems/ruby'

class Ruby_thwait < RUBY
  description 'Watches for termination of multiple threads.'
  homepage 'https://github.com/ruby/thwait'
  version "0.2.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_e2mmap' # R

  conflicts_ok
  no_compile_needed
end
