require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.10.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1ad09f13edbef8f973081a4ee77fcf317d30e9ea9b70686f262edeeea4af7248',
     armv7l: '1ad09f13edbef8f973081a4ee77fcf317d30e9ea9b70686f262edeeea4af7248',
       i686: '365b749d007bec944e6c77bef3a44bbacafc7cd28d3a67b1022129924a83c0dc',
     x86_64: 'bb2c2663d01ed74c9152d18faf5d058179ddc33ed9fb086599cfff19b42b83cd'
  })

  depends_on 'ninja'
  depends_on 'python3'

  no_source_build
end
