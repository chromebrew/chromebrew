require 'buildsystems/pip'

class Py3_pyproject_hooks < Pip
  description 'This package contains wrappers to call hooks on build backends for pyproject.toml -based projects'
  homepage 'https://pyproject-hooks.readthedocs.io/'
  version "1.3.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c1abed621b68d9b869bd52a55fe9de81d11eab13261f7f2c214d0defc27093f6',
     armv7l: 'c1abed621b68d9b869bd52a55fe9de81d11eab13261f7f2c214d0defc27093f6',
       i686: '641d1e4796e0cc6411724e9ce3c5ea335240d7d0b874968dbd4262ccd74971f5',
     x86_64: 'ebf9fec8134e3377d50f2cd9c5ae8912e9c3ad4779a9eca4b36bdd13e0664054'
  })

  depends_on 'py3_tomli'
  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
