require 'buildsystems/pip'

class Py3_build < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://pypa-build.readthedocs.io/'
  version "1.6.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5f7676c6e9bdc7ad65da9e9118b786569b7dcf7d54bfd164192c13ff58f4a990',
     armv7l: '5f7676c6e9bdc7ad65da9e9118b786569b7dcf7d54bfd164192c13ff58f4a990',
       i686: 'e057e6b93225b776291b8481e1674093e386cab275c0ea21bf672ba6174ff4f5',
     x86_64: 'df4cdb6c90a270be2afbf698eaf01b32233e5d27c55a9dc8dc2d3de49493306b'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_pyproject_hooks'
  depends_on 'py3_tomli'
  depends_on 'python3' => :logical

  no_source_build
end
