require 'buildsystems/ruby'

class Ruby_nokogiri < RUBY
  description 'Nokogiri (鋸) makes it easy and painless to work with XML and HTML from Ruby.'
  homepage 'https://nokogiri.org'
  version "1.19.7-#{CREW_RUBY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '8fb029d852167e8f4d9aa954892de4260b43dc96a090f5b0ac5a734fb43b7fdb',
     armv7l: '8fb029d852167e8f4d9aa954892de4260b43dc96a090f5b0ac5a734fb43b7fdb',
       i686: '8d800192273998626d8ba2ee2e636859760e594496e7d09a5a02d829532bf2ff',
     x86_64: 'a5fd2db6e6b949789eeff13ee912189d4dfeeb3eebf1a8b9e522722e9046bc38'
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
