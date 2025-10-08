require 'buildsystems/ruby'

class Ruby_bigdecimal < RUBY
  description 'This library provides arbitrary-precision decimal floating-point number class.'
  homepage 'https://github.com/ruby/bigdecimal'
  version "3.3.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'd3951bcecd72889c5267c89bc1ed916c4eb15d07a53fb59c144de0471383e8b4',
     armv7l: 'd3951bcecd72889c5267c89bc1ed916c4eb15d07a53fb59c144de0471383e8b4',
       i686: 'db1b7c22e05bf0a4809d55fc55fd691c2babbf8b343d894f2155f1511f1009cb',
     x86_64: '54193c93d8a90fab6ff83ab4967d7b4b8bdaf56797f48b1e2938d7d0c02bd111'
  })

  conflicts_ok
  gem_compile_needed
end
