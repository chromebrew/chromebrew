require 'buildsystems/ruby'

class Ruby_kramdown < RUBY
  description 'Kramdown is yet-another-markdown-parser but fast, pure Ruby, using a strict syntax definition and supporting several common extensions.'
  homepage 'http://kramdown.gettalong.org'
  version "2.5.1-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_kramdown' # R
  depends_on 'ruby_rexml' # R

  conflicts_ok
  no_compile_needed
end
