require 'buildsystems/ruby'

class Ruby_activesupport < RUBY
  description 'A toolkit of support libraries and Ruby core extensions extracted from the Rails framework.'
  homepage 'https://rubyonrails.org/'
  version "8.0.2-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_base64'
  depends_on 'ruby_bigdecimal'
  depends_on 'ruby_concurrent_ruby'
  depends_on 'ruby_connection_pool'
  depends_on 'ruby_drb'
  depends_on 'ruby_i18n'
  depends_on 'ruby_logger'
  depends_on 'ruby_minitest'
  depends_on 'ruby_securerandom'
  depends_on 'ruby_tzinfo'

  conflicts_ok
  no_compile_needed
end
