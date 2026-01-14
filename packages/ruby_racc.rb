require 'buildsystems/ruby'

class Ruby_racc < RUBY
  description 'Racc is a LALR(1) parser generator.'
  homepage 'https://github.com/ruby/racc'
  version "1.8.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'cbbbd3e0d2527efcd8202d38cd3310bf58a7a88ee6e1f080d4a0d36d6065c1eb',
     armv7l: 'cbbbd3e0d2527efcd8202d38cd3310bf58a7a88ee6e1f080d4a0d36d6065c1eb',
       i686: '3854dbcc451a4c3913da62afe0b4ed05f16a2805c43587a09e58c84d76b25fef',
     x86_64: '3f5522004826d0ef99e0f248812e80338d8c1deadd198c22fb062ceb82e872d3'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
