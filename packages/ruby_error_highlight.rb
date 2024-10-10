require 'buildsystems/ruby'

class Ruby_error_highlight < RUBY
  description 'The gem enhances exception#message by adding a short explanation where the exception is raised.'
  homepage 'https://github.com/ruby/error_highlight'
  version "0.6.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
