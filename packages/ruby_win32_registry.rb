require 'buildsystems/ruby'

class Ruby_win32_registry < RUBY
  description 'Provides an interface to the Windows Registry in Ruby'
  homepage 'https://github.com/ruby/win32-registry'
  version "0.1.2-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'win32'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
