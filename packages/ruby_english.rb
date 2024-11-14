require 'buildsystems/ruby'

class Ruby_english < RUBY
  description "Require 'english."
  homepage 'https://github.com/ruby/English'
  version "0.8.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
