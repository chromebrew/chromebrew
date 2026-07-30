require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "3.32.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'acbfa86cb24fc092a8e42c0753f4bd0c48ca80dcafad6f2450032addbdeddfa0',
     armv7l: 'acbfa86cb24fc092a8e42c0753f4bd0c48ca80dcafad6f2450032addbdeddfa0',
       i686: '603c72d43ac5f3bc6de6888bcf59c1faaa0dbec6a3993b56f9760eb9f50cccdf',
     x86_64: '085d4c8c2fe490d9b7e00ce66b220f46096c7dc6accb0cbc1c727155a5a6b0dd'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
