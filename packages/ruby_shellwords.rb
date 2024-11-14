require 'buildsystems/ruby'

class Ruby_shellwords < RUBY
  description 'Manipulates strings with word parsing rules of unix bourne shell.'
  homepage 'https://github.com/ruby/shellwords'
  version "0.2.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
