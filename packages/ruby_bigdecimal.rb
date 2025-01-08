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
    aarch64: 'ccc52e1f36c916a352f90b59367c83bce3bfe16bb44c67cc38b34f54729494fa',
     armv7l: 'ccc52e1f36c916a352f90b59367c83bce3bfe16bb44c67cc38b34f54729494fa',
       i686: 'fea6ba80da5a0a19be636472efeabefa5e721f378198609d1f155cafb26ba057',
     x86_64: 'e118909d8a08595fe5925339c728257a211cf1942db8d4050e526c2ac94a6287'
  })

  conflicts_ok
  gem_compile_needed
end
