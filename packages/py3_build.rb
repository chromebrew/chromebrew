require 'buildsystems/pip'

class Py3_build < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://pypa-build.readthedocs.io/'
  version "1.5.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dc45af60224c72fb6ec9dcf311f749bf14948c86f112d4bfe20a6167118bdb52',
     armv7l: 'dc45af60224c72fb6ec9dcf311f749bf14948c86f112d4bfe20a6167118bdb52',
       i686: '4be83f61774c7767d6c3d032b1ba8f261a2fa8ce311cd8e20900d660d102ed5f',
     x86_64: 'a410e60de28f68741c7875c85cc83885c286d23e2f23a1e125e59f22a08f157b'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_pyproject_hooks'
  depends_on 'py3_tomli'
  depends_on 'python3' => :logical

  no_source_build
end
