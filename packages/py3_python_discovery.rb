require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.2.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ce08edaf6d8d701b4109e43cf54b2c6ed6876d24d95012247b86b02c7396507',
     armv7l: '2ce08edaf6d8d701b4109e43cf54b2c6ed6876d24d95012247b86b02c7396507',
       i686: 'b0831028bfa23479981956e3d755293579e9bc9949ee8b7291cc337d6e2465bd',
     x86_64: 'eb8466019d0e096e6f107f5b10c731e1a8271e6c9bc3d2336da13fb452bc0cff'
  })

  depends_on 'python3' => :logical

  no_source_build
end
