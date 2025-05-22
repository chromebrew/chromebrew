require 'buildsystems/ruby'

class Ruby_method_source < RUBY
  description 'retrieve the sourcecode for a method.'
  homepage 'http://banisterfiend.wordpress.com'
  version "1.1.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
