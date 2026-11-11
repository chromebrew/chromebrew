require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.2.10-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0daf5c0ec8091ec009c703fcc32bd9cbc14d2d3edb3bc8362d1f5f8293399349',
     armv7l: '0daf5c0ec8091ec009c703fcc32bd9cbc14d2d3edb3bc8362d1f5f8293399349',
       i686: 'dc04cd12c59f185281865d501d58a0006ff258673815658d2d073b1775f192a4',
     x86_64: '604f94add245bda8e09bfdbadfe2edceb2c2c3c9a3a149304700ec902ac891e9'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
