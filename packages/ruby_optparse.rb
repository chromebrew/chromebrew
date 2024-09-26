require 'buildsystems/ruby'

class Ruby_optparse < RUBY
  description 'OptionParser is a class for command-line option analysis.'
  homepage 'https://github.com/ruby/optparse'
  version "0.5.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
