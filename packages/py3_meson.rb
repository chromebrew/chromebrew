require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.9.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '824b33919f3aa1a40826286db15df2242cbc4646423a9dcb04ca17d0e863d53d',
     armv7l: '824b33919f3aa1a40826286db15df2242cbc4646423a9dcb04ca17d0e863d53d',
       i686: '6fcd0eb465bbf569b57314d49064c9dabb6738bf4be273171c4aec167886b58b',
     x86_64: '89c5d4d7131d4db384363ac5c3c1a7cc482f3f6baf93a05a606a686a68f42585'
  })

  depends_on 'ninja'
  depends_on 'python3'

  no_source_build
end
