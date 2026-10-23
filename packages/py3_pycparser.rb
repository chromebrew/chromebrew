require 'buildsystems/pip'

class Py3_pycparser < Pip
  description 'PyCParser is a complete C99 parser in pure Python.'
  homepage 'https://github.com/eliben/pycparser/'
  version "3.12-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '689e99aa1f2d8f9ae270e5d7e498ae245be41d2db6d3ca63e2a4e84f1733d589',
     armv7l: '689e99aa1f2d8f9ae270e5d7e498ae245be41d2db6d3ca63e2a4e84f1733d589',
       i686: 'cc6a5948acc369256a1faa18dd29d24dfc89fb68f2f6e371d562466d8558e5fb',
     x86_64: '4c6dbf98427769942210dd9c1a9267e4c6a84e40fadc680f127e4dd6b596be22'
  })

  depends_on 'python3' => :logical

  no_source_build
end
