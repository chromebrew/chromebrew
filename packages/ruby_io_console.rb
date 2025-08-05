require 'buildsystems/ruby'

class Ruby_io_console < RUBY
  description 'add console capabilities to IO instances.'
  homepage 'https://github.com/ruby/io-console'
  version "0.8.1-#{CREW_RUBY_VER}"
  license 'BSD-2-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'gem'

  binary_sha256({
    aarch64: 'ffdac0f757bcef6149a861d461290a22d5be5c03cdde27450297d1605ad7d516',
     armv7l: 'ffdac0f757bcef6149a861d461290a22d5be5c03cdde27450297d1605ad7d516',
       i686: 'b13e17e63eb453cf871dcd3dca24fb5620aee619bb842f863888060f34ef9663',
     x86_64: '7f4de5173f80bc06fd9c9cdaa2a31e26df030706dd62adfc32d7d135efdb4529'
  })

  conflicts_ok
  gem_compile_needed
end
