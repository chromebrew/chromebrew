require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.0.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3a338b4f1317ed1e7d1f9bb1b38fc38c3ecfc337055fc45e306a94cfa235cf7d',
     armv7l: '3a338b4f1317ed1e7d1f9bb1b38fc38c3ecfc337055fc45e306a94cfa235cf7d',
       i686: '29c8f42a50a27d4b9e63e71199861f9855e99a4a419d42a8458726feff2fb502',
     x86_64: 'd61311a09d98dc4029f15ef6e870c9d79301fdb9cf05a969de7b5dff38c377a4'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
