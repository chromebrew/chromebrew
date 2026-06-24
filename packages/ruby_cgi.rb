require 'buildsystems/ruby'

class Ruby_cgi < RUBY
  description 'Support for the common gateway interface protocol.'
  homepage 'https://github.com/ruby/cgi'
  version "0.5.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '0b5a41bb1dadf0892b321bd2120c350f8b08353c753e074a15eb9f3e6331d182',
     armv7l: '0b5a41bb1dadf0892b321bd2120c350f8b08353c753e074a15eb9f3e6331d182',
       i686: 'c7240c3740a009774344c98bcf1527e88b8d3d23bda5705a5dbddde296657aec',
     x86_64: '8f215daf5e8a3fbfe8513b72d992b6a26e389cecdd99c45b8ce322f6b64445f3'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
