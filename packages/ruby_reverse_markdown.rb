require 'buildsystems/ruby'

class Ruby_reverse_markdown < RUBY
  description 'Map simple html back into markdown.'
  homepage 'http://github.com/xijo/reverse_markdown'
  version "3.0.0-#{CREW_RUBY_VER}"
  license 'WTFPL'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_nokogiri' # R

  conflicts_ok
  no_compile_needed
end
