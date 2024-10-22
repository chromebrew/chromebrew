require 'buildsystems/pip'

class Py3_meson_python < Pip
  description 'Meson Python build backend (PEP 517)'
  homepage 'https://pypi.org/project/meson-python'
  version "0.17.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '85751e807a4cbf54e495a235698cffc821df2be1b0ab6b41774865db8624ed65',
     armv7l: '85751e807a4cbf54e495a235698cffc821df2be1b0ab6b41774865db8624ed65',
       i686: '9f0258ffb3ce08f43bd69114f61316cb8198e97edf142f4c1a3bbabb86d569a6',
     x86_64: '0d1d7ad8770b8dc1aec31a406a76401522288fe703966cb64c66360bc198adda'
  })

  depends_on 'python3'

  no_source_build
end
