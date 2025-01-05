require 'buildsystems/ruby'

class Ruby_bigdecimal < RUBY
  description 'This library provides arbitrary-precision decimal floating-point number class.'
  homepage 'https://github.com/ruby/bigdecimal'
  version "3.1.9-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '6f83b65983097fe238cc21e29cc7994182828f2a10f9e193d4683c35a8fd5c5a',
     armv7l: '6f83b65983097fe238cc21e29cc7994182828f2a10f9e193d4683c35a8fd5c5a',
       i686: 'fea6ba80da5a0a19be636472efeabefa5e721f378198609d1f155cafb26ba057',
     x86_64: 'd7627122a608700c9b1322b71e553ec19554b02359acdc700aa29c37290297fc'
  })

  conflicts_ok
  gem_compile_needed
end
