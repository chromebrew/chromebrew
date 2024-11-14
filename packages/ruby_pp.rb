require 'buildsystems/ruby'

class Ruby_pp < RUBY
  description 'Provides a prettyprinter for ruby objects.'
  homepage 'https://github.com/ruby/pp'
  version "0.5.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_base64' # R
  depends_on 'ruby_bigdecimal' # R
  depends_on 'ruby_concurrent_ruby' # R
  depends_on 'ruby_connection_pool' # R
  depends_on 'ruby_drb' # R
  depends_on 'ruby_i18n' # R
  depends_on 'ruby_logger' # R
  depends_on 'ruby_minitest' # R
  depends_on 'ruby_prettyprint' # R
  depends_on 'ruby_securerandom' # R
  depends_on 'ruby_tzinfo' # R
  depends_on 'ruby_httparty' # R

  conflicts_ok
  no_compile_needed
end
