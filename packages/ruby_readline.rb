require 'buildsystems/ruby'

class Ruby_readline < RUBY
  description "This is just a loader for 'readline'."
  homepage 'https://github.com/ruby/readline'
  version "0.0.4-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_reline' # R

  conflicts_ok
  no_compile_needed
end
