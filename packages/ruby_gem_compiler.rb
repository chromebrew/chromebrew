require 'buildsystems/ruby'

class Ruby_gem_compiler < RUBY
  description 'Gem-compiler is a plugin that helps generates binary gems from already existing ones without altering the original source code.'
  homepage 'https://github.com/luislavena/gem-compiler'
  version '0.9.0-ruby-3.3'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
