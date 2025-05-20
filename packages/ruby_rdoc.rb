require 'buildsystems/ruby'

class Ruby_rdoc < RUBY
  description 'RDoc produces HTML and command-line documentation for Ruby projects.'
  homepage 'https://ruby.github.io/rdoc'
  version "6.14.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_psych' # R

  conflicts_ok
  no_compile_needed
end
