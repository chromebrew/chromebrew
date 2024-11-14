require 'buildsystems/ruby'

class Ruby_yaml_lint < RUBY
  description 'Check if your YAML files can be loaded.'
  homepage 'https://rubygems.org/gems/yaml-lint'
  version "0.1.2-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  no_compile_needed
end
