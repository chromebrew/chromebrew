require 'buildsystems/ruby'

class Ruby_ruby2_keywords < RUBY
  description '---.'
  homepage 'https://github.com/ruby/ruby2_keywords'
  version "0.0.5-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
