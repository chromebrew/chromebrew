require 'buildsystems/pip'

class Py3_build < Pip
  description 'Python build is a simple, correct PEP 517 build frontend.'
  homepage 'https://pypa-build.readthedocs.io/'
  version "1.3.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cc0bd7d5cc2ff63ec8fd6f7b9f78628cce0fa7d7a09ed74e3c3b29722313d8b9',
     armv7l: 'cc0bd7d5cc2ff63ec8fd6f7b9f78628cce0fa7d7a09ed74e3c3b29722313d8b9',
       i686: '08e4574c31917c7cd93980ffe4cb32eef4bfb3a5629dff2b7521ea87c036a694',
     x86_64: '3bdb4962ff19ec9673dcb3884cbb334137b936eac355922f1e73f82b9cbbd83a'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'
  depends_on 'py3_pyproject_hooks'
  depends_on 'py3_tomli'

  no_source_build
end
