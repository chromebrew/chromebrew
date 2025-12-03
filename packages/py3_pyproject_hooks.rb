require 'buildsystems/pip'

class Py3_pyproject_hooks < Pip
  description 'This package contains wrappers to call hooks on build backends for pyproject.toml -based projects'
  homepage 'https://pyproject-hooks.readthedocs.io/'
  version "1.2.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0ab6e768a39d869e8e7db43982dd62a2ca5016adbd680433c8f9a876d705fc13',
     armv7l: '0ab6e768a39d869e8e7db43982dd62a2ca5016adbd680433c8f9a876d705fc13',
       i686: 'd7dee37e18fdbb9d8ed1ac7690f41c806a10ee677c02f2d975e9f30f2c2f3bb4',
     x86_64: '95fedaa2f88f1668a353c99db1115c158da02f746ef209b23c5d1ea5798764b2'
  })

  depends_on 'python3'
  depends_on 'py3_tomli'

  no_source_build
end
