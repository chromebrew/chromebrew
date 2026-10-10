require 'buildsystems/pip'

class Py3_requests_toolbelt < Pip
  description 'A collection of utilities for python-requests,'
  homepage 'https://toolbelt.readthedocs.io'
  version "1.0.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3eb9684d7b430bb8bebd62cfd4dc8000b4f1b3b92d32838d5919184551bedc8a',
     armv7l: '3eb9684d7b430bb8bebd62cfd4dc8000b4f1b3b92d32838d5919184551bedc8a',
       i686: 'cc25efce4f75731e9f34d4e367a33584b877e8ded7a0c89bbdcf3914cce3e863',
     x86_64: '43bb5353792ad66ece8be32ae6feb243fb3c229ec14c7222f626f680dd2300ed'
  })

  depends_on 'py3_requests'
  depends_on 'python3' => :logical

  no_source_build
end
