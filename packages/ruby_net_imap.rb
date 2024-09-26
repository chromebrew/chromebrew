require 'buildsystems/ruby'

class Ruby_net_imap < RUBY
  description 'Ruby client api for Internet Message Access Protocol'
  homepage 'https://github.com/ruby/net-imap'
  version "0.4.16-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
