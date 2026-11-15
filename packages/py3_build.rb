require 'buildsystems/pip'

class Py3_build < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://pypa-build.readthedocs.io/'
  version "1.6.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eb704f70f8587f3c7bf43e879f483fc9e9a410e451367f8c30392b66cdbed652',
     armv7l: 'eb704f70f8587f3c7bf43e879f483fc9e9a410e451367f8c30392b66cdbed652',
       i686: '50b61ae4594c2eb9bc680876bc22665ab4c66ca44ab9349a0433ad814e144bce',
     x86_64: 'e0d18c4e3ff24c9ecfa96f53ded0151a1605277f5ee0b58cc6c4204b644f978e'
  })

  depends_on 'py3_packaging'
  depends_on 'py3_pyproject_hooks'
  depends_on 'py3_tomli'
  depends_on 'python3' => :logical

  no_source_build
end
