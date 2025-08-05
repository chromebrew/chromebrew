require 'buildsystems/ruby'

class Ruby_net_imap < RUBY
  description 'Ruby client api for Internet Message Access Protocol'
  homepage 'https://github.com/ruby/net-imap'
  version "0.5.9-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_date' # R
  depends_on 'ruby_net_protocol' # R

  conflicts_ok
  no_compile_needed
end
