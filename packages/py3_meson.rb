require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.8.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '00a913d55057d9264d6baa710f8aea6e5704f0cc84879a2eb8153cdae9dc9c9a',
     armv7l: '00a913d55057d9264d6baa710f8aea6e5704f0cc84879a2eb8153cdae9dc9c9a',
       i686: '7f1097304c654a6d8c2d4f676a997c80da67ff1100d870141df6de1a7e473854',
     x86_64: '6b89ef59cb792ba807212af7b4a927c0480cf81e2c7a7d7ba0a31e46e00c7c8f'
  })

  depends_on 'ninja'
  depends_on 'samurai'
  depends_on 'python3'

  no_source_build
end
