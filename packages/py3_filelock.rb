require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/benediktschmitt/py-filelock/'
  version "3.17.0-#{CREW_PY_VER}"
  license 'Unlicense'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bf1481ea759a4219be96c8ffcd1131c6e0a5d8dd998ea8a43e305d1768b4dfca',
     armv7l: 'bf1481ea759a4219be96c8ffcd1131c6e0a5d8dd998ea8a43e305d1768b4dfca',
       i686: 'c8e22b92b2ba5aad8cae8107be6f422acf330f2a0c5f6ad6eff8fd9ea1d52a52',
     x86_64: 'ae8db374c781847b84bc9b9142145f1a9df70cdd3c537e3ad8ae2bfdd87c8fee'
  })

  depends_on 'python3' => :build

  no_source_build
end
