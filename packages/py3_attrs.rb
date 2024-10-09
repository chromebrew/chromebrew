require 'buildsystems/pip'

class Py3_attrs < Pip
  description 'Attrs removes the need to implement object protocols in classes.'
  homepage 'https://www.attrs.org/'
  version "24.2.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bef2eb706e6e38159cd7658597c1ba0843c2fb3ec0c8e10d419cb56b4ff2f521',
     armv7l: 'bef2eb706e6e38159cd7658597c1ba0843c2fb3ec0c8e10d419cb56b4ff2f521',
       i686: '4cc37959d660964cf9748ba639807d487ae1bfe4c7042b8568437c86e93cb9d6',
     x86_64: '81b5cb4f23f0fe01afe430d6366a9c6b17f14c70dce9cc3daa28a54874b5df69'
  })

  depends_on 'python3' => :build
  depends_on 'py3_hatchling' => :build
  depends_on 'py3_hatch_vcs' => :build

  no_source_build
end
