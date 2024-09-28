require 'buildsystems/ruby'

class Ruby_abbrev < RUBY
  description 'Calculates a set of unique abbreviations for a given set of strings.'
  homepage 'https://github.com/ruby/abbrev'
  version "0.1.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
