require 'buildsystems/ruby'

class Ruby_erb < RUBY
  description 'An easy to use but powerful templating system for Ruby.'
  homepage 'https://github.com/ruby/erb'
  version "6.0.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'b7d64a0a23af4ead9e992061be8f8bfc52b2bef1e0a7035e6aa091b41ce6109e',
     armv7l: 'b7d64a0a23af4ead9e992061be8f8bfc52b2bef1e0a7035e6aa091b41ce6109e',
       i686: '6ba91f9a8fbfd55f2c9dd80f75ccd14a71b88747f2983bcb43b3588149d6db0c',
     x86_64: '5b27a0dc7a5777deccec27e9b2c739b783eaa4b90c00fce2bd708019dd86fdb8'
  })

  depends_on 'ruby_cgi' # R

  conflicts_ok
  gem_compile_needed
end
