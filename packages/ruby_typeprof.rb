require 'buildsystems/ruby'

class Ruby_typeprof < RUBY
  description 'TypeProf performs a type analysis of non-annotated Ruby code.'
  homepage 'https://github.com/ruby/typeprof'
  version "0.21.11-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_rbs' # R

  conflicts_ok
  no_compile_needed
end
