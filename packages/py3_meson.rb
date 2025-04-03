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
    aarch64: '315af0015077026dd2a44fa6ad79bd0b2abe55d33557e4105293925926a7dad6',
     armv7l: '315af0015077026dd2a44fa6ad79bd0b2abe55d33557e4105293925926a7dad6',
       i686: '19145f859f79e6c2fd9467f75f847ed2119305e427c5ae3672b86019bc614e7f',
     x86_64: '5d1882a5c26aaee75445aca7862ad20647844cf7d029514d99279f2d729d1a4d'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'

  no_source_build
end
