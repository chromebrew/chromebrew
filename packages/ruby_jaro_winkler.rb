require 'buildsystems/ruby'

class Ruby_jaro_winkler < RUBY
  description "Jaro_winkler is an implementation of Jaro-Winkler distance algorithm which is written in C extension and will fallback to pure Ruby version in platforms other than MRI/KRI like JRuby or Rubinius."
  homepage 'https://github.com/tonytonyjan/jaro_winkler'
  version "1.6.1-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
