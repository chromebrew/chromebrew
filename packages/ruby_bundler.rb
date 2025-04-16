require 'buildsystems/ruby'

class Ruby_bundler < RUBY
  description "Bundler manages an application's dependencies through its entire life, across many machines, systematically and repeatably."
  homepage 'https://bundler.io'
  version "2.6.8-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
