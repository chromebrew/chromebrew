require 'buildsystems/ruby'

class Ruby_ruby_progressbar < RUBY
  description 'Ruby/ProgressBar is an extremely flexible text progress bar library for Ruby.'
  homepage 'https://github.com/jfelchner/ruby-progressbar'
  version "1.13.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
