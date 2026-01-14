require 'buildsystems/ruby'

class Ruby_sdbm < RUBY
  description 'Provides a simple file-based key-value store with String keys and values.'
  homepage 'https://github.com/ruby/sdbm'
  version "1.0.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '61d0da88da540206991566a5744eb633707721d50988140b9c7c20380f2eef83',
     armv7l: '61d0da88da540206991566a5744eb633707721d50988140b9c7c20380f2eef83',
       i686: 'ae8031479d3f8c611bcb28b8b7adca7058479891f6eca7a13cd451d0fcd56383',
     x86_64: '5983723193ed335bb093ee8e5b954a412354100964d930b45314f48aa694b453'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
