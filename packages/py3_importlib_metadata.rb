require 'buildsystems/pip'

class Py3_importlib_metadata < Pip
  description 'Importlib metadata reads metadata from Python packages.'
  homepage 'https://github.com/python/importlib_metadata/'
  version "8.7.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '616d4d25f0a1d3638bbf1628d0d6459ec93a322d70cf01ddb48db1a718ab3801',
     armv7l: '616d4d25f0a1d3638bbf1628d0d6459ec93a322d70cf01ddb48db1a718ab3801',
       i686: '17a1c31c8c44bb63ca18393ce7d1672ac46c5d0f1a4151f550e1b4c0e930c055',
     x86_64: '95f674e7385f55c9e2653e546bbb2dab60900b9a57420ac3b51ab967c0f2fb2b'
  })

  depends_on 'py3_zipp'
  depends_on 'python3' => :build

  no_source_build
end
