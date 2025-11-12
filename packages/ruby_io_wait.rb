require 'buildsystems/ruby'

class Ruby_io_wait < RUBY
  description 'Waits until io is readable or writable without blocking.'
  homepage 'https://github.com/ruby/io-wait'
  version "0.3.5-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '686c587c0c89de60f13dfc6df30386af380cb54968844f79f1d457aba931be79',
     armv7l: '686c587c0c89de60f13dfc6df30386af380cb54968844f79f1d457aba931be79',
       i686: '0bdda7421f86b40b5759132fe6b15e767a2f3ffbf2c0e08a3ae1438108f3d4b6',
     x86_64: '9872d8a205160da83910b54fc6f684e2306f15a667ea3665b2c848bd2b877645'
  })

  conflicts_ok
  gem_compile_needed
end
