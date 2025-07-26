require 'buildsystems/ruby'

class Ruby_yard < RUBY
  description 'YARD is a documentation generation tool for the Ruby programming language.'
  homepage 'http://yardoc.org'
  version "0.9.37-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_yard' # R

  conflicts_ok
  no_compile_needed
end
