require 'buildsystems/ruby'

class Ruby_erb < RUBY
  description 'An easy to use but powerful templating system for Ruby.'
  homepage 'https://github.com/ruby/erb'
  version "5.0.3-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '0d0e7ffe322279f998e7377d70a3c7811ba4bf756ed1609038712bef31a0747f',
     armv7l: '0d0e7ffe322279f998e7377d70a3c7811ba4bf756ed1609038712bef31a0747f',
       i686: 'c88da38525143741170ba59a1f0e91ed71d7a69d93a005f83af83b952060f983',
     x86_64: 'f739696f1c0e0adc617381d276d06ae4d12c8fc3c0024fbc13b724d90b1389cb'
  })

  depends_on 'ruby_cgi' # R

  conflicts_ok
  gem_compile_needed
end
