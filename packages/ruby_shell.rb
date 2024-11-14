require 'buildsystems/ruby'

class Ruby_shell < RUBY
  description 'An idiomatic Ruby interface for common UNIX shell commands.'
  homepage 'https://github.com/ruby/shell'
  version "0.8.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_e2mmap' # R
  depends_on 'ruby_sync' # R

  conflicts_ok
  no_compile_needed
end
