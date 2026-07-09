require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.4.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a628e72912fdad9e4a8b22e15dff89fc46699fafd9290b2e1f3d440ae1a7988d',
     armv7l: 'a628e72912fdad9e4a8b22e15dff89fc46699fafd9290b2e1f3d440ae1a7988d',
       i686: '3cf70e0a862e5de0a387a034764a9188f8a18d430bf4462b77dc8f116c22014e',
     x86_64: '572c21fe3c06c46aedbb67f4fe6e74838dcb8b83c56132ae331649fb353c014f'
  })

  depends_on 'python3' => :logical

  no_source_build
end
