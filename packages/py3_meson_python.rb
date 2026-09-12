require 'buildsystems/pip'

class Py3_meson_python < Pip
  description 'Meson Python build backend (PEP 517)'
  homepage 'https://pypi.org/project/meson-python'
  version "0.21.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '597b4c5fac2159b56ca082cf18424e81f35517e355840b08f9c64911bd3a8f86',
     armv7l: '597b4c5fac2159b56ca082cf18424e81f35517e355840b08f9c64911bd3a8f86',
       i686: 'a6c38453c7840c56379d4b77c52b198513c2dae150be6f7723eb02567b86bc90',
     x86_64: 'dcc83bdedf12f92b9f5fac5032a36a4ca3c81728c89308b1b12d753d5666a4ed'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
