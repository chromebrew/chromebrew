require 'buildsystems/ruby'

class Ruby_weakref < RUBY
  description 'Allows a referenced object to be garbage-collected.'
  homepage 'https://github.com/ruby/weakref'
  version "0.1.4-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_delegate' # R

  conflicts_ok
  no_compile_needed
end
