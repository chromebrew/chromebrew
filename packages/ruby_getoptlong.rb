require 'buildsystems/ruby'

class Ruby_getoptlong < RUBY
  description 'Getoptlong for ruby.'
  homepage 'https://github.com/ruby/getoptlong'
  version "0.2.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
