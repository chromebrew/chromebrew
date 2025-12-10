require 'buildsystems/pip'

class Py3_itsdangerous < Pip
  description 'ItsDangerous provide various helpers to pass data to untrusted environments and back.'
  homepage 'https://palletsprojects.com/p/itsdangerous/'
  version "2.2.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'adfcb3d634f917e168d29bc298be25cbac381f6813de9280dbf05eb26c173f38',
     armv7l: 'adfcb3d634f917e168d29bc298be25cbac381f6813de9280dbf05eb26c173f38',
       i686: '7a426ef3347f7078dc2568c16613f8fccd4d3de3d7173bb83fc1029af919171f',
     x86_64: '1c7334ddf64487e196e5b0df8f4c3a932d8873607a2dea9ce39396c921f602cb'
  })

  depends_on 'python3' => :build

  no_source_build
end
