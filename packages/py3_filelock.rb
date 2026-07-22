require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "3.32.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'aafe54ded4955bf8bd2f44d934644ab67f9b9b0b2fef526e6de4f6b3dc3b4199',
     armv7l: 'aafe54ded4955bf8bd2f44d934644ab67f9b9b0b2fef526e6de4f6b3dc3b4199',
       i686: 'b32139f4650649b55b355cd7fc739f7aaf393d818cded863a17d843e912411e9',
     x86_64: '63c55c8c3afd4c2d8e26d197c49321f4cead91aca3ee0b34d06f70b00071a75b'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
