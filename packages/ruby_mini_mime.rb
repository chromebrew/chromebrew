require 'buildsystems/ruby'

class Ruby_mini_mime < RUBY
  description 'A minimal mime type library.'
  homepage 'https://github.com/discourse/mini_mime'
  version "1.1.5-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
