require 'buildsystems/ruby'

class Ruby_csv < RUBY
  description 'tools to enable you to read and write to and from Strings or IO objects, as needed.'
  homepage 'https://github.com/ruby/csv'
  version "3.3.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
