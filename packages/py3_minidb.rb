require 'buildsystems/pip'

class Py3_minidb < Pip
  description 'Minidb is a simple SQLite3-based store for Python objects.'
  homepage 'https://thp.io/2010/minidb/'
  version "2.0.8-#{CREW_PY_VER}"
  license 'ISC'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a92de47d57a9c9d5048b057f87713c14e91ea65adfb2c36828c9f9ce5e2d7524',
     armv7l: 'a92de47d57a9c9d5048b057f87713c14e91ea65adfb2c36828c9f9ce5e2d7524',
       i686: '91eb38dc1ba5b4475718c4a3bc5bee5a8d35c58ef488578830d612c6e0c269fa',
     x86_64: '24d173b1879a4866d67236c07c36f34ff2b0699eeb17ed0a15af3fecf9e55b19'
  })

  depends_on 'python3' => :build

  no_source_build
end
