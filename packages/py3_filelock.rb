require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/benediktschmitt/py-filelock/'
  version "3.20.0-#{CREW_PY_VER}"
  license 'Unlicense'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '995b5c75d0dd123a021b2c75824912848cc6296768be72e2dad3a7b821cf68b3',
     armv7l: '995b5c75d0dd123a021b2c75824912848cc6296768be72e2dad3a7b821cf68b3',
       i686: 'f39e3cf251fb3169d8dbfb4d0c5a8e2bba3a66ad90c856007ba3247903efddd9',
     x86_64: '8107950748c86cbe3d94a1496c298536e9daf5367c3343b02faa32aeace912fa'
  })

  depends_on 'python3' => :build

  no_source_build
end
