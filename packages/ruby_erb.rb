require 'buildsystems/ruby'

class Ruby_erb < RUBY
  description 'An easy to use but powerful templating system for Ruby.'
  homepage 'https://github.com/ruby/erb'
  version "5.0.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '20386ddf0f42eace56dda587c2f24cc2b0ac561ebf798f940e0b540e9b6f5e08',
     armv7l: '20386ddf0f42eace56dda587c2f24cc2b0ac561ebf798f940e0b540e9b6f5e08',
       i686: '9634bed863357b5de28b541020b2f2db16505dda744ab8f83caf7babbd0c12c9',
     x86_64: 'e2c3d4bd5c15bc13e610f7ea52bbe70876eede8674bc2a27f281c169ab1b95dd'
  })

  depends_on 'ruby_cgi' # R

  conflicts_ok
  gem_compile_needed
end
