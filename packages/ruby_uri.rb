require 'buildsystems/ruby'

class Ruby_uri < RUBY
  description 'Uri is a module providing classes to handle uniform resource identifiers.'
  homepage 'https://github.com/ruby/uri'
  version "0.13.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_stringio' # R
  depends_on 'ruby_time' # R
  depends_on 'ruby_uri' # R

  conflicts_ok
  no_compile_needed
end
