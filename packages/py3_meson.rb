require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.8.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5aad16926c807ee221b366f4b7d1376214ba9dde0f4c619240ceb48f54c94048',
     armv7l: '5aad16926c807ee221b366f4b7d1376214ba9dde0f4c619240ceb48f54c94048',
       i686: 'bb8f7761b2c4e4092016a140864e6a5527b5604ac175ea22ae41dfda03bbe4bc',
     x86_64: '68fa5dc3b7afaa11de4604fcc15c4bf8b5fcea93122f7b2322949c10f5cc579c'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'

  no_source_build
end
