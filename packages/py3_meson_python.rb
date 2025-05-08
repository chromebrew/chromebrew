require 'buildsystems/pip'

class Py3_meson_python < Pip
  description 'Meson Python build backend (PEP 517)'
  homepage 'https://pypi.org/project/meson-python'
  version "0.18.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '61ac0749525db1ab7a566d674cf9ac688a988e2916d188d40629ebfbedac37eb',
     armv7l: '61ac0749525db1ab7a566d674cf9ac688a988e2916d188d40629ebfbedac37eb',
       i686: '03b4c1d07c8443127e8a253bd804d278c41e033607bbdd7d113cf01e3cccac41',
     x86_64: '2d6a10f6169b325a6ae3b799e4977422d0f537301a67ce1f86d4b1f5e962fdd1'
  })

  depends_on 'python3'

  no_source_build
end
