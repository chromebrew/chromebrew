require 'buildsystems/ruby'

class Ruby_sdbm < RUBY
  description 'Provides a simple file-based key-value store with String keys and values.'
  homepage 'https://github.com/ruby/sdbm'
  version "1.0.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
