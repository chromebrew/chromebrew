require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.7.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ca83684d38e62c2ce00704e22229f78546a6a2cb8f36743d2e14f5904e6826de',
     armv7l: 'ca83684d38e62c2ce00704e22229f78546a6a2cb8f36743d2e14f5904e6826de',
       i686: 'c624cc8ce5ad6ed59f3d9cbb2f792030843d5defaeaab34976f79c79342e1724',
     x86_64: 'cb7c32f90629d8e027e2e00df3c21810aad97697f09783e19bf9dfc8a8cea602'
  })

  depends_on 'python3' => :build

  no_source_build
end
