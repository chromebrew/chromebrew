require 'buildsystems/ruby'

class Ruby_ostruct < RUBY
  description 'Class to build custom data structures, similar to a hash.'
  homepage 'https://github.com/ruby/ostruct'
  version "0.6.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
