require 'buildsystems/ruby'

class Ruby_drb < RUBY
  description 'Distributed object system for ruby.'
  homepage 'https://github.com/ruby/drb'
  version "2.2.3-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_ruby2_keywords' # R

  conflicts_ok
  no_compile_needed
end
