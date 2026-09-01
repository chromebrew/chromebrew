require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "3.32.5-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8403031b2cf0f09212b382ea4444c804e756670d14fdbf010e3ce8b1b2e63437',
     armv7l: '8403031b2cf0f09212b382ea4444c804e756670d14fdbf010e3ce8b1b2e63437',
       i686: 'f5610db4b25c263a9993346e83cd7fd1e1ec341b343887d8e62dd576de2319d6',
     x86_64: '7b8f7ee2adfdfd83b37d640c9cd17383bf9b67072db76b25ea5ce5f7198f1297'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
