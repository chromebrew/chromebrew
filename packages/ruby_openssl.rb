require 'buildsystems/ruby'

class Ruby_openssl < RUBY
  description 'Openssl for ruby provides access to ssl/tls and general-purpose cryptography based on the openssl library.'
  homepage 'https://github.com/ruby/openssl'
  version "4.0.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'd7d1602fd90ca2ff48da90b28192ee1351f06483b727eb3763ba1741369df883',
     armv7l: 'd7d1602fd90ca2ff48da90b28192ee1351f06483b727eb3763ba1741369df883',
       i686: '60982fb4d80017f4c438dd6ab056eaa13d1bc66fabfdc58edb42f9ad8e4e0323',
     x86_64: 'eb9d34ddf4fed15311d04bb94271640848586af4f882d930affa2710cd901e73'
  })

  depends_on 'glibc' => :library
  depends_on 'openssl' => :library
  depends_on 'ruby' => :library

  conflicts_ok
  gem_compile_needed
end
