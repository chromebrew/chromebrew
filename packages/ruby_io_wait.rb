require 'buildsystems/ruby'

class Ruby_io_wait < RUBY
  description 'Waits until io is readable or writable without blocking.'
  homepage 'https://github.com/ruby/io-wait'
  version "0.3.3-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  conflicts_ok
  gem_compile_needed
end
