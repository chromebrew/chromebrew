require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.8.3-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2d59e0be8b5ae4b07258a7157000f2407efe620212d3ed0e51242c44ef6751d3',
     armv7l: '2d59e0be8b5ae4b07258a7157000f2407efe620212d3ed0e51242c44ef6751d3',
       i686: '7316255d7f74ea657c9bd177c097b2cb5c700af65623ed257c43ff4a66534675',
     x86_64: 'd173a0c7e157e9219ae28abc66e1350854445dd5852ef450b79eb92868afa07f'
  })

  depends_on 'ninja'
  depends_on 'python3'

  no_source_build
end
