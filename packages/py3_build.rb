require 'buildsystems/pip'

class Py3_build < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://pypa-build.readthedocs.io/'
  version "1.3.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '756f99ead88f946edb7f8493e4c0380fad005e688a60723321c61df3222fb5d0',
     armv7l: '756f99ead88f946edb7f8493e4c0380fad005e688a60723321c61df3222fb5d0',
       i686: 'acefa2d97b93c27d820e548a6e92f5041512de731bffd1b776e6f6377bf13098',
     x86_64: 'e7958897dd7cc2e509db83f23937f2ec2cf9d61b0e2e3d25eb5166bac81c163c'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'
  depends_on 'py3_pyproject_hooks'
  depends_on 'py3_tomli'

  no_source_build
end
