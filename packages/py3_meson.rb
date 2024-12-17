require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.6.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '51dfdd3279e346edb42bcda051d4031291e75196557484b4030444581aa23472',
     armv7l: '51dfdd3279e346edb42bcda051d4031291e75196557484b4030444581aa23472',
       i686: '21d9f9f6614716f74770c5ef0b069fea1eb302e3353e88654896bc8e4e1d26cf',
     x86_64: '42e3ee05d2f6caf08572762f2df9cd5287e66bfd64d58609a7378a213ae93dbe'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'

  no_source_build
end
