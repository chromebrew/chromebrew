require 'buildsystems/pip'

class Py3_pycparser < Pip
  description 'PyCParser is a complete C99 parser in pure Python.'
  homepage 'https://github.com/eliben/pycparser/'
  version "3.11-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c4756d807cc087f30ad399cf7859181443f0e6f40737091edf3d9e3f60d23af0',
     armv7l: 'c4756d807cc087f30ad399cf7859181443f0e6f40737091edf3d9e3f60d23af0',
       i686: '686743119c2db74aad343e43f52767d6deac4dec57bab2517a8c2a77c4f63619',
     x86_64: 'ca4a999a733594216bc531069351e3e2be9ee6129a770ab5febbb939cad5c4dd'
  })

  depends_on 'python3' => :logical

  no_source_build
end
