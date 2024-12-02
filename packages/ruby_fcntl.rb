require 'buildsystems/ruby'

class Ruby_fcntl < RUBY
  description 'Loads constants defined in the os fcntl.'
  homepage 'https://github.com/ruby/fcntl'
  version "1.2.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
