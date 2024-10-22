require 'buildsystems/pip'

class Py3_pyxdg < Pip
  description 'PyXDG contains implementations of freedesktop.org standards in python.'
  homepage 'https://freedesktop.org/wiki/Software/pyxdg/'
  version "0.28-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b0e027c8a2cdeeb3cb9ea7b658d29fad8827e52e2a9d4746938d684138f62e4c',
     armv7l: 'b0e027c8a2cdeeb3cb9ea7b658d29fad8827e52e2a9d4746938d684138f62e4c',
       i686: '2a402e65a7dcc76094e0932cfbdd481153dbd5e0f8d1a36f97a38993ae5d20cb',
     x86_64: 'd2a2cbb926226a5096f02b4191c540d1897ed339805c2a4fd9997d56e5f1c4d6'
  })

  depends_on 'python3' => :build

  no_source_build
end
