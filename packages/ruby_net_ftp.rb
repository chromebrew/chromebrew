require 'buildsystems/ruby'

class Ruby_net_ftp < RUBY
  description 'Support for the File Transfer Protocol.'
  homepage 'https://github.com/ruby/net-ftp'
  version "0.3.7-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
