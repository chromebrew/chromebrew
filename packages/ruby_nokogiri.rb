require 'buildsystems/ruby'

class Ruby_nokogiri < RUBY
  description 'Nokogiri (鋸) makes it easy and painless to work with XML and HTML from Ruby.'
  homepage 'https://nokogiri.org'
  version "1.19.4-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '1a6d0e2f3417875befbd2a222a3ba7922603f2d2b6ed116e1d4ec26605b220f8',
     armv7l: '1a6d0e2f3417875befbd2a222a3ba7922603f2d2b6ed116e1d4ec26605b220f8',
       i686: '621fa5fe06255d8b8940c342053d5f2717b96a78f71b4e6f3d4c68941721ba63',
     x86_64: '9c37e23427179b71ba38488d07caa039c93cb63256f89c2bb390dc4f77acadfc'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'ruby' => :library
  depends_on 'ruby_mini_portile2' # R
  depends_on 'ruby_racc' # R
  depends_on 'xzutils' => :library
  depends_on 'zlib' => :library

  conflicts_ok
  gem_compile_needed
end
