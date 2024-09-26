require 'buildsystems/ruby'

class Ruby_nkf < RUBY
  description 'Ruby extension for Network Kanji Filter'
  homepage 'https://github.com/ruby/nkf'
  version "0.2.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  gem_compile_needed
  no_source_build
end
