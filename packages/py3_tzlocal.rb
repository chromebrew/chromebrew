require 'buildsystems/pip'

class Py3_tzlocal < Pip
  description 'Tzlocal provides tzinfo object for the local timezone.'
  homepage 'https://github.com/regebro/tzlocal/'
  version "5.3.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4e2255b7ec25da632d436068da81618cac064e786324b3d35cb54db1ee315915',
     armv7l: '4e2255b7ec25da632d436068da81618cac064e786324b3d35cb54db1ee315915',
       i686: '789943f2424f447691cf8c4b60de990c9f056cc99d957a2ff97631900e7658a2',
     x86_64: '62f8a5eafed409fc1c76323e3b1dc69bf4a1daf50ea45de438fcb1a5f2cb08a8'
  })

  depends_on 'py3_pytz'
  depends_on 'python3' => :build

  no_source_build
end
