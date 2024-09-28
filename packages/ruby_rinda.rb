require 'buildsystems/ruby'

class Ruby_rinda < RUBY
  description 'The linda distributed computing paradigm in ruby.'
  homepage 'https://github.com/ruby/rinda'
  version "0.2.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_drb' # R
  depends_on 'ruby_forwardable' # R
  depends_on 'ruby_ipaddr' # R

  conflicts_ok
  no_compile_needed
end
