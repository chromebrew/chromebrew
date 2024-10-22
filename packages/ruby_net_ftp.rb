require 'buildsystems/ruby'

class Ruby_net_ftp < RUBY
  description 'Support for the File Transfer Protocol.'
  homepage 'https://github.com/ruby/net-ftp'
  version "0.3.8-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_net_protocol' # R
  depends_on 'ruby_time' # R

  conflicts_ok
  no_compile_needed
end
