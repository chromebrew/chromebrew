require 'buildsystems/pip'

class Py3_wheel < Pip
  description 'Wheel is the binary package format for python.'
  homepage 'https://wheel.readthedocs.io/'
  version "0.48.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'af288f7f8b2c010136c73b1cdb3ecf2feebaa512229aea5e3352ce9271c55fd9',
     armv7l: 'af288f7f8b2c010136c73b1cdb3ecf2feebaa512229aea5e3352ce9271c55fd9',
       i686: '0c8444f1ba8bd08eeaf0baf18971e6c1482100d9e3d4687ccdd5492eb1d5e7ad',
     x86_64: '6c2fdcbcd862197f8d3e520a6d66ac70a06c47d9b36168e5ae70b6b4a48cbb16'
  })

  depends_on 'py3_packaging'
  depends_on 'python3' => :logical

  no_source_build
end
