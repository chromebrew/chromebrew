require 'buildsystems/pip'

class Py3_wheel < Pip
  description 'Wheel is the binary package format for python.'
  homepage 'https://wheel.readthedocs.io/'
  version "0.45.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2a783a6525648463e8b6b1c130b9df517d26ef1b6a0f1b10b10db82bfde33e84',
     armv7l: '2a783a6525648463e8b6b1c130b9df517d26ef1b6a0f1b10b10db82bfde33e84',
       i686: '9c27b364a334309868b9996d64118e27d17e2a6c51b555343725f9b1765bd7d1',
     x86_64: '359bdff17b4c3a73b0c492a73754f0e98d5d5feb775996b78c45151329cd1920'
  })

  depends_on 'python3'
  depends_on 'py3_packaging'

  no_source_build
end
