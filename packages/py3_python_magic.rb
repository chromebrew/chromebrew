require 'buildsystems/pip'

class Py3_python_magic < Pip
  description 'Magic is a python wrapper for libmagic.'
  homepage 'https://github.com/ahupp/python-magic/'
  version "0.4.27-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e7e338d0340ab76592378569e5236094edc9495e1abfd479022b0121a26938a1',
     armv7l: 'e7e338d0340ab76592378569e5236094edc9495e1abfd479022b0121a26938a1',
       i686: 'e486b92745fa9dc71bd7dc0728c37025cb2975a97356f38cf953497763fa71ed',
     x86_64: '24e8817c2008b0a7b882893150588493e6fe40f61e60138d1234911958739f69'
  })

  depends_on 'filecmd'
  depends_on 'python3' => :logical

  no_source_build
end
