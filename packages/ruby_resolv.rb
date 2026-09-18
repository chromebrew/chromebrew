require 'buildsystems/ruby'

class Ruby_resolv < RUBY
  description 'Thread-aware dns resolver library in ruby.'
  homepage 'https://github.com/ruby/resolv'
  version "0.8.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '57ca935d75f405d315885f5c68fa901ca9de8d29dc1cd086bafa833f4507d5ff',
     armv7l: '57ca935d75f405d315885f5c68fa901ca9de8d29dc1cd086bafa833f4507d5ff',
       i686: '9fa61d0b27aa99ef088dd88922e339af94238ca8aa152bb3fc9340ee5547841f',
     x86_64: '1d50c35c107107cfd3a0d299f4bc3c075bca3fe63bc0c416a96e5df4e5f6802a'
  })

  depends_on 'ruby' => :logical

  conflicts_ok
  gem_compile_needed
end
