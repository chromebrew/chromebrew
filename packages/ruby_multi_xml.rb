require 'buildsystems/ruby'

class Ruby_multi_xml < RUBY
  description '---.'
  homepage 'https://github.com/sferik/multi_xml'
  version "0.7.2-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_bigdecimal' # R

  conflicts_ok
  no_compile_needed
end
