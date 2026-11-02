require 'buildsystems/ruby'

class Ruby_nokogiri < RUBY
  description 'Nokogiri (鋸) makes it easy and painless to work with XML and HTML from Ruby.'
  homepage 'https://nokogiri.org'
  version "1.19.5-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '1cc3ab2f63004170a476b66e5ca39378ab04d2382afe35840a1e631359d05916',
     armv7l: '1cc3ab2f63004170a476b66e5ca39378ab04d2382afe35840a1e631359d05916',
       i686: '1063ea2269b10ef3621cb6f1f34cea5c39db7a870f7f4311d7b5adf6ca3c362c',
     x86_64: '344797dd0c09d7cd048444ad6d130cef75d093b83b787ca7ed744fa20e511cf4'
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
