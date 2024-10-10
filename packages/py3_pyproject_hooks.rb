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
    aarch64: 'b70efdca42e62e6e54e52364530f19307b85ca982e77db7e52cd77b9e4eb74b1',
     armv7l: 'b70efdca42e62e6e54e52364530f19307b85ca982e77db7e52cd77b9e4eb74b1',
       i686: '8b64d2527e166695994657db57a1ca785737c3ca0f15090164b5f45baf22e3d2',
     x86_64: '40b620bbbc9f8c2cc73c0ecb9116719a6a46d464742f8e7f8e68b808a96fc418'
  })

  depends_on 'python3'
  depends_on 'py3_tomli'

  no_source_build
end
