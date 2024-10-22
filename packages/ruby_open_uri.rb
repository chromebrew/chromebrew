require 'buildsystems/ruby'

class Ruby_open_uri < RUBY
  description 'An easy-to-use wrapper for net::http, net::https and net::ftp.'
  homepage 'https://github.com/ruby/open-uri'
  version "0.4.1-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_stringio' # R
  depends_on 'ruby_time' # R
  depends_on 'ruby_uri' # R

  conflicts_ok
  no_compile_needed
end
