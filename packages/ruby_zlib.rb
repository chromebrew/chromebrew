require 'buildsystems/ruby'

class Ruby_zlib < RUBY
  description 'Ruby interface for the zlib compression/decompression library.'
  homepage 'https://github.com/ruby/zlib'
  version "3.2.2-#{CREW_RUBY_VER}"
  license 'Ruby'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '808d7aba79667a448935b18243b0357988684293395276efd6647043166dc2fd',
     armv7l: '808d7aba79667a448935b18243b0357988684293395276efd6647043166dc2fd',
       i686: '6d89bd6d766bf926b881fd0dff56ed291d6dddc94e8b9b4a2e6adedf0a767ce9',
     x86_64: '738d1c5977805dca87c79d7ed640497f0164e0ca4eea27defd263758eead1f91'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R
  depends_on 'zlib' # R

  conflicts_ok
  gem_compile_needed
end
