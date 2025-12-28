require 'buildsystems/ruby'

class Ruby_debug < RUBY
  description 'The debug library provides debugging functionality to Ruby (MRI) 2.7 and later.'
  homepage 'https://github.com/ruby/debug'
  version "1.11.1-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '0ac1a3cfe5d8e32b22ea1cc40fc43da8101527b3a29527fd377f6d088c4b841e',
     armv7l: '0ac1a3cfe5d8e32b22ea1cc40fc43da8101527b3a29527fd377f6d088c4b841e',
       i686: '08a57d34a170a3ae46277d32b5b1afa7aa7ab1c59f356221d0ddf3e39dcfdb44',
     x86_64: '12cf6ca041125b269134f00c594b3ecfcda9afdd3ad52661679708b1ab03f0bd'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R
  depends_on 'ruby_irb' # R
  depends_on 'ruby_reline' # R

  conflicts_ok
  gem_compile_needed
  no_source_build
end
