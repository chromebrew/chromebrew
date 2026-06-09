require 'buildsystems/pip'

class Py3_distlib < Pip
  description 'Distlib provides distribution utilities for Python packages.'
  homepage 'https://bitbucket.org/pypa/distlib/'
  version "0.4.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd030964273b67c17b8f95dbfe31c3df4dd5b4766b5556699fe4de5d6a04d454c',
     armv7l: 'd030964273b67c17b8f95dbfe31c3df4dd5b4766b5556699fe4de5d6a04d454c',
       i686: 'f244622fa0ca6bf9841e39d8afb1373cbd1dfa0bd4e0d2a04d526d9f0c46a8c0',
     x86_64: '7a2d8f3fecfca05b62f40e2a58ef9bab55853cac741b6166827f42ac83779c1d'
  })

  depends_on 'python3' => :logical

  no_source_build
end
