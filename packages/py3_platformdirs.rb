require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.11.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '805a5170a0f6595a309db3f9413423dbaf9d788fe267e53149716d3072322ca6',
     armv7l: '805a5170a0f6595a309db3f9413423dbaf9d788fe267e53149716d3072322ca6',
       i686: '14851c5fcfe248e88a6dce35e4d24c25c216792a97451b70da1381db6ec4f2fa',
     x86_64: '486c53c5157f438fe0366d714612002e02402106b76daf242ef7e39c82318192'
  })

  depends_on 'python3' => :logical

  no_source_build
end
