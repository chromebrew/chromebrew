require 'buildsystems/ruby'

class Ruby_yaml < RUBY
  description "Yaml ain't markup language."
  homepage 'https://github.com/ruby/yaml'
  version "0.3.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
