require 'buildsystems/ruby'

class Ruby_rexml < RUBY
  description 'An XML toolkit for Ruby'
  homepage 'https://github.com/ruby/rexml'
  version "3.3.8-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
