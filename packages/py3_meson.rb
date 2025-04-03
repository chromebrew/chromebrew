require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.7.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b01df4adb5cac91939a21d08aa7cd7f15018f3bf87df4c8e8435653656dbd6cb',
     armv7l: 'b01df4adb5cac91939a21d08aa7cd7f15018f3bf87df4c8e8435653656dbd6cb',
       i686: '7cf2ee933cf7b8727a304ec41bff3a4cff46ba1c6c9eea7cd0769f8a02a925b2',
     x86_64: '5d1882a5c26aaee75445aca7862ad20647844cf7d029514d99279f2d729d1a4d'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'

  no_source_build
end
