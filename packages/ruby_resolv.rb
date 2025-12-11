require 'buildsystems/ruby'

class Ruby_resolv < RUBY
  description 'Thread-aware dns resolver library in ruby.'
  homepage 'https://github.com/ruby/resolv'
  version "0.7.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'f2bdc1d2d8d68a70cab48321cd7b65f8b1c103b5e3689ed08aabf7ecfcf64855',
     armv7l: 'f2bdc1d2d8d68a70cab48321cd7b65f8b1c103b5e3689ed08aabf7ecfcf64855',
       i686: '94f5a1f352662b3a60738c60b9c570cdbe5b59cb6907801d06228b19ab513307',
     x86_64: 'ee8a9be47f12205d67a40f4d8f0b057a52ea62c0d26c39b8b4fc8c6b35fd055b'
  })

  conflicts_ok
  gem_compile_needed
end
