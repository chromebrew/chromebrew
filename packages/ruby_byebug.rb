require 'buildsystems/ruby'

class Ruby_byebug < RUBY
  description 'Byebug is a Ruby debugger.'
  homepage 'https://github.com/deivid-rodriguez/byebug'
  version "13.0.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '27ad307c9e7d2b42995709c43b2b1691cab696a7f7cf85e701792e9dc75f0fe8',
     armv7l: '27ad307c9e7d2b42995709c43b2b1691cab696a7f7cf85e701792e9dc75f0fe8',
       i686: '904b07651a49f2175d7850cdf951739ed591fc46907be705de254975ae6b7bc3',
     x86_64: '0a2110371bc3fe6acdef442eedd788b5121f265c3d237a69e7380525fc96cd8a'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
