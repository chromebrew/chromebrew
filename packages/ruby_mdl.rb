require 'buildsystems/ruby'

class Ruby_mdl < RUBY
  description 'Style checker/lint tool for markdown files.'
  homepage 'https://github.com/markdownlint/markdownlint'
  version "0.13.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
