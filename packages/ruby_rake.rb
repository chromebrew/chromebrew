require 'buildsystems/ruby'

class Ruby_rake < RUBY
  description 'Rake is a Make-like program implemented in Ruby.'
  homepage 'https://github.com/ruby/rake'
  version "13.2.1-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
