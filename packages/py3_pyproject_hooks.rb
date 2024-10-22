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
       i686: '3e225c2921b952570479176b48e4ac4a20cb365cbb610655604b49f04c04f0fc',
     x86_64: 'f9d8306849dea9f86a4a8cc8cf0f5f8a7a6fe9994e070c0f3603ca5de8141369'
  })

  depends_on 'python3'
  depends_on 'py3_tomli'

  no_source_build
end
