require 'buildsystems/ruby'

class Ruby_resolv < RUBY
  description 'Thread-aware dns resolver library in ruby.'
  homepage 'https://github.com/ruby/resolv'
  version "0.5.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'c28efd69d8d6e2a04ede2b3d61f68427a8350678f01dcc3b27f2af267016c56c',
     armv7l: 'c28efd69d8d6e2a04ede2b3d61f68427a8350678f01dcc3b27f2af267016c56c',
       i686: 'aa700af01d3abca7808f2d9f77273bcbf552d92771982206ce6b57e38682adde',
     x86_64: '3ac05f4dcd9478ceb1ed1268f00dda03b990423334867be9a4295814c4896fe7'
  })

  conflicts_ok
  gem_compile_needed
end
