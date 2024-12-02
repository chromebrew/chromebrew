require 'buildsystems/ruby'

class Ruby_psych < RUBY
  description '| psych is a yaml parser and emitter.'
  homepage 'https://github.com/ruby/psych'
  version "5.2.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'ruby_stringio' # R

  conflicts_ok
  no_compile_needed
end
