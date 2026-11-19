require 'buildsystems/pip'

class Py3_python_discovery < Pip
  description 'Python interpreter discovery'
  homepage 'https://github.com/tox-dev/python-discovery'
  version "1.9.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bbbd9061f86d78394ce15a7893d295d9a9eb300812769c7f883c88798a0e50e2',
     armv7l: 'bbbd9061f86d78394ce15a7893d295d9a9eb300812769c7f883c88798a0e50e2',
       i686: '0fb31db3a8644d0b3bf4bf378f18feb4a55ebf8c6a366af5aec64c72cd412de4',
     x86_64: 'c180b6fd720a7a459dc8f15206f74a6d01737fe2458d849b45ad87eeabb22fdc'
  })

  depends_on 'python3' => :logical

  no_source_build
end
