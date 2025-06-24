require 'buildsystems/ruby'

class Ruby_matrix < RUBY
  description 'An implementation of Matrix and Vector classes.'
  homepage 'https://github.com/ruby/matrix'
  version "0.4.3-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
