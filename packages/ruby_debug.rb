require 'buildsystems/ruby'

class Ruby_debug < RUBY
  description 'The debug library provides debugging functionality to Ruby (MRI) 2.7 and later.'
  homepage 'https://github.com/ruby/debug'
  version '1.9.2-ruby-3.3'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  gem_compile_needed
  no_source_build
end
