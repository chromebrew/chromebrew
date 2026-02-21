require 'buildsystems/ruby'

class Ruby_multi_xml < RUBY
  description 'A generic swappable back-end for XML parsing'
  homepage 'https://github.com/sferik/multi_xml'
  version "0.8.1-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_bigdecimal' # R

  conflicts_ok
  no_compile_needed
  upstream_name 'multi_xml'
end
