require 'buildsystems/ruby'

class Ruby_dbm < RUBY
  description 'Provides a wrapper for the UNIX-style Database Manager Library.'
  homepage 'https://github.com/ruby/dbm'
  version "1.1.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
