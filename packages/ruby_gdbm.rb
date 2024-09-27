require 'buildsystems/ruby'

class Ruby_gdbm < RUBY
  description 'Ruby extension for GNU dbm.'
  homepage 'https://github.com/ruby/gdbm'
  version "2.1.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
