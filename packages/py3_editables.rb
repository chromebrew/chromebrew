require 'buildsystems/pip'

class Py3_editables < Pip
  description 'A Python library for creating "editable wheels"'
  homepage 'https://editables.readthedocs.io'
  version "0.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3d99cef2ad8a101c4df609891d7ec8c7fceab8d61e9861af35c96df12ac91a34',
     armv7l: '3d99cef2ad8a101c4df609891d7ec8c7fceab8d61e9861af35c96df12ac91a34',
       i686: '97c7c4f8072e3b75f5560ba7058ca91ca27858387ea5e615f7bda4c1cfda5518',
     x86_64: '46c74edf4748aae06650490dce267a896d0ee74b147a00923187710dc90c6ca3'
  })

  depends_on 'python3' => :build

  no_source_build
end
