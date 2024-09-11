require 'buildsystems/pip'

class Py3_meson_python < Pip
  description 'Meson Python build backend (PEP 517)'
  homepage 'https://pypi.org/project/meson-python'
  version '0.16.0-py3.12'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3b2658d5379d3fedb2f2654ceaf7255dc95542b15a911022be59627b6df09061',
     armv7l: '3b2658d5379d3fedb2f2654ceaf7255dc95542b15a911022be59627b6df09061',
       i686: '2fc3d1d211e2ef6c75af2644832058cfd57e0fac973c95709b038ce54a1e8739',
     x86_64: '8da2aaa9bd4f9c43e7cebdd6490e38799aea9b0211fdbdb3f3ea72b765970e97'
  })

  depends_on 'python3'

  no_source_build
end
