require 'buildsystems/pip'

class Py3_meson_python < Pip
  description 'Meson Python build backend (PEP 517)'
  homepage 'https://pypi.org/project/meson-python'
  version "0.22.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bcfbf0d49d0cb4c6a4e8ee6bc396031f64ddb5fe50595d1eced37c1b19fa71d7',
     armv7l: 'bcfbf0d49d0cb4c6a4e8ee6bc396031f64ddb5fe50595d1eced37c1b19fa71d7',
       i686: 'a6223b529cd0d1250b0f250e151999c8236df20e02aeaa46b19a0529a2a285ed',
     x86_64: '8aa540e7f40e8e42f0853fd37cb6b384f4420f4c3089c9987a9b7ec510e94d73'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
