require 'buildsystems/pip'

class Py3_platformdirs < Pip
  description 'A small Python package for determining appropriate platform-specific dirs.'
  homepage 'https://pypi.org/project/platformdirs'
  version "4.12.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b1049bef39b49c3e8692efeb3fae058c46891720d8d491572eef5c6e51e16c2b',
     armv7l: 'b1049bef39b49c3e8692efeb3fae058c46891720d8d491572eef5c6e51e16c2b',
       i686: '6f10a7ec050bb1223d960e93f60e7a8f9ba3a821b38756351fe227be77ae8ffa',
     x86_64: 'bb1d0fb52b52efba8e88cfd595da4cfc5cd86f2c0a046385dad4ffb97a56f847'
  })

  depends_on 'python3' => :logical

  no_source_build
end
