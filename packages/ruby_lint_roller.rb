require 'buildsystems/ruby'

class Ruby_lint_roller < RUBY
  description 'A plugin specification for linter and formatter rulesets'
  homepage 'https://github.com/standardrb/lint_roller'
  version "1.1.0-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
