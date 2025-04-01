require 'buildsystems/ruby'

class Ruby_httparty < RUBY
  description 'Makes http fun! Also, makes consuming restful web services dead easy.'
  homepage 'https://github.com/jnunemaker/httparty'
  version "0.23.1-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_csv' # R
  depends_on 'ruby_mini_mime' # R
  depends_on 'ruby_multi_xml' # R

  conflicts_ok
  no_compile_needed
end
