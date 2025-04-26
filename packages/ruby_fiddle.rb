require 'buildsystems/ruby'

class Ruby_fiddle < RUBY
  description 'A libffi wrapper for ruby.'
  homepage 'https://github.com/ruby/fiddle'
  version "1.1.8-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '26220d4ffd4e747bfd5084adaf4d6ed32b07686314dda9825e1985f41406213b',
     armv7l: '26220d4ffd4e747bfd5084adaf4d6ed32b07686314dda9825e1985f41406213b',
       i686: '60ea5261f339048e9393cc1d8fac09c92303a55a3b0ef238482148a8e3e27b54',
     x86_64: 'cef809e4077462985d057aed36aa63fd2569fa8246754f5d7f918c15c87795b7'
  })

  conflicts_ok
  gem_compile_needed
end
