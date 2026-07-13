require 'buildsystems/ruby'

class Ruby_rdoc < RUBY
  description 'RDoc produces HTML and command-line documentation for Ruby projects.'
  homepage 'https://ruby.github.io/rdoc'
  version "8.0.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby' => :logical
  depends_on 'ruby_erb' => :logical
  depends_on 'ruby_prism' => :logical
  depends_on 'ruby_rbs' => :logical
  depends_on 'ruby_tsort' => :logical

  conflicts_ok
  no_compile_needed
end
