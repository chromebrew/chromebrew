require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.11.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '33f202fc51aab50fac29ce4e8c64a77fa7bd9a2e8ad20e3d95936b4d580780df',
     armv7l: '33f202fc51aab50fac29ce4e8c64a77fa7bd9a2e8ad20e3d95936b4d580780df',
       i686: '9867ed1a9625bf14cc62732a25ccdba53a62e523a90715c65b2a643f2581f50d',
     x86_64: 'cc63443d76b4ed6c9c67411419b52d2bdc2519dc197947e6f5aeefb7bdc70f1e'
  })

  depends_on 'ninja'
  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
