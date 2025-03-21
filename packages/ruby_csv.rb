require 'buildsystems/ruby'

class Ruby_csv < RUBY
  description 'The csv library provides a complete interface to csv files and data.'
  homepage 'https://github.com/ruby/csv'
  version "3.3.3-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
