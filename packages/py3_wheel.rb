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
    aarch64: '77427d50e5c0ce2af6d6dc3f101b6f7ddc6a0e66fb9dee1213c89a4a988b003b',
     armv7l: '77427d50e5c0ce2af6d6dc3f101b6f7ddc6a0e66fb9dee1213c89a4a988b003b',
       i686: '4027bcaa39d23e1ffbf6b0f23892b5f7c0c97fdfee8c6194fd82b4eb0bf43fca',
     x86_64: 'f559bd3f2d7483daed0f2b28f0fc712692df4fea546b669cbf19833f5d97891a'
  })

  depends_on 'py3_packaging'
  depends_on 'python3' => :logical

  no_source_build
end
