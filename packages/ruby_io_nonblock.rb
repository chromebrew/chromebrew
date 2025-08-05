require 'buildsystems/ruby'

class Ruby_io_nonblock < RUBY
  description 'Enables non-blocking mode with io class.'
  homepage 'https://github.com/ruby/io-nonblock'
  version "0.3.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'

  conflicts_ok
  no_compile_needed
end
