require 'buildsystems/pip'

class Py3_build < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://pypa-build.readthedocs.io/'
  version "1.2.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5dd5fc28e84646e756b4df2d64838a585256b6d02730ac16fcd0a8978e20ad10',
     armv7l: '5dd5fc28e84646e756b4df2d64838a585256b6d02730ac16fcd0a8978e20ad10',
       i686: '0eb0869da28e19e7280abe1f5469e19a3433747bfc3cf575ef895a16fbe52366',
     x86_64: '659e70fa8eb4c4be7c09958a0212bc141a6e4e0c81c3cdd1e1fb844a1301025b'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'
  depends_on 'py3_pyproject_hooks'
  depends_on 'py3_tomli'

  no_source_build
end
