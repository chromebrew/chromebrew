require 'buildsystems/ruby'

class Ruby_e2mmap < RUBY
  description 'Module for defining custom exceptions with specific messages.'
  homepage 'https://github.com/ruby/e2mmap'
  version "0.1.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
