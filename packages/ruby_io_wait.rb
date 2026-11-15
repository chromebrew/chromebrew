require 'buildsystems/ruby'

class Ruby_io_wait < RUBY
  description 'Waits until io is readable or writable without blocking.'
  homepage 'https://github.com/ruby/io-wait'
  version "1.0.0-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  depends_on 'glibc' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  no_compile_needed
end
