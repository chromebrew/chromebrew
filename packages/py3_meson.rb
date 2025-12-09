require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.10.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4f7cc49ccb8d5d11998f2b2ca2ea22e8be2a4df0eefb46644520132df91eccdf',
     armv7l: '4f7cc49ccb8d5d11998f2b2ca2ea22e8be2a4df0eefb46644520132df91eccdf',
       i686: '9c83da63ca51b95baf02efe1f93e7aa3150c2c58c445653e03f8f0425ae51bcb',
     x86_64: 'c4e9f47be86a89f446f499ba76be0e6a3ba06a350a9d7d40338198bbaa201c03'
  })

  depends_on 'ninja'
  depends_on 'python3'

  no_source_build
end
