require 'buildsystems/ruby'

class Ruby_mutex_m < RUBY
  description 'Mixin to extend objects to be handled like a mutex.'
  homepage 'https://github.com/ruby/mutex_m'
  version "0.2.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
