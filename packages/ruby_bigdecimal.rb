require 'buildsystems/ruby'

class Ruby_bigdecimal < RUBY
  description 'This library provides arbitrary-precision decimal floating-point number class.'
  homepage 'https://github.com/ruby/bigdecimal'
  version "4.0.0-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: '58b913c9a897996db80828b688669d0bcab4d630efdfc2e1011154bf5c727009',
     armv7l: '58b913c9a897996db80828b688669d0bcab4d630efdfc2e1011154bf5c727009',
       i686: 'c937df0fa4a84aebfe3cd6619216e70f84b569d956e4b9f3e2a9245dba34ff47',
     x86_64: '5a46b96dc505c5fb48ae3b292fd7197f515e9a46e87bce40d96e20ef9db95d56'
  })

  depends_on 'glibc' # R
  depends_on 'ruby' # R

  conflicts_ok
  gem_compile_needed
end
