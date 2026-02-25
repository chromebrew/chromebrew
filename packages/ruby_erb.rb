require 'buildsystems/ruby'

class Ruby_erb < RUBY
  description 'An easy to use but powerful templating system for Ruby.'
  homepage 'https://github.com/ruby/erb'
  version "6.0.2-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'f00f735be5ec6732a6798434f6b7b67454e7aa38d89dfe501096d125d318e611',
     armv7l: 'f00f735be5ec6732a6798434f6b7b67454e7aa38d89dfe501096d125d318e611',
       i686: 'c0349254b4cd87a8fecc8abfe5de399eb7c480a0b14f1d6a0d467b62217f07d8',
     x86_64: '762fc51660e8ee6fadb93ff3d3ae7a2ca5b6f6464d1d02fab2d017b5765fa09a'
  })

  depends_on 'ruby_cgi' # R

  conflicts_ok
  gem_compile_needed
end
