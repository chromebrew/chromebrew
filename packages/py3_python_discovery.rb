require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.6.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc5e24b3c3d1d80782bde898d4fd1057a1002d81b3d6739920fce78f5992e5ea',
     armv7l: 'fc5e24b3c3d1d80782bde898d4fd1057a1002d81b3d6739920fce78f5992e5ea',
       i686: '09f10e8aadbe8538cd2ef1219c1e79f1acfd7d26b5c4c6b224c177afd5ba9a69',
     x86_64: 'a96f0435834566d1f728d970bb7d021133743eed488c25e477f272720fe15254'
  })

  depends_on 'python3' => :logical

  no_source_build
end
