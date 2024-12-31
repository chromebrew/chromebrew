require 'buildsystems/ruby'

class Ruby_bigdecimal < RUBY
  description 'This library provides arbitrary-precision decimal floating-point number class.'
  homepage 'https://github.com/ruby/bigdecimal'
  version "3.1.8-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '6f83b65983097fe238cc21e29cc7994182828f2a10f9e193d4683c35a8fd5c5a',
     armv7l: '6f83b65983097fe238cc21e29cc7994182828f2a10f9e193d4683c35a8fd5c5a',
       i686: 'f3e1120d5707bee46d5d0d8c7dda45ca8c3da1fb62224803742528cdbc25f0f2',
     x86_64: 'd7627122a608700c9b1322b71e553ec19554b02359acdc700aa29c37290297fc'
  })

  conflicts_ok
  gem_compile_needed
end
