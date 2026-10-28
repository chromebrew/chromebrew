require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.6.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '56731461d4f618134b7c0e3bde34f959c9a89b8272ea418f808428fc8bc2918d',
     armv7l: '56731461d4f618134b7c0e3bde34f959c9a89b8272ea418f808428fc8bc2918d',
       i686: '561d05c1552a633bde0eadec440a65a27bc494c0a90ecabd378988087e00645b',
     x86_64: '0f7bbf8a0077d0b61abc66bef2ab7df2e87b2f6040b1a02a74ff8419e2dd6ccf'
  })

  depends_on 'python3' => :logical

  no_source_build
end
