require 'buildsystems/ruby'

class Ruby_ptools < RUBY
  description "The ptools (power tools) library is an additional set of commands for the File class based on Unix command line tools."
  homepage 'https://github.com/djberg96/ptools'
  version "1.5.0-#{CREW_RUBY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
