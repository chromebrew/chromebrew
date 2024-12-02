require 'buildsystems/ruby'

class Ruby_etc < RUBY
  description 'Provides access to information typically stored in unix /etc directory.'
  homepage 'https://github.com/ruby/etc'
  version "1.4.4-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  conflicts_ok
  gem_compile_needed
end
