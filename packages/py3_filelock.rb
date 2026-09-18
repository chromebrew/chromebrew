require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4b89feeadbe412808ef13a99c98e082bd3ef1f6bd237f47ce7f0654e7363e0c9',
     armv7l: '4b89feeadbe412808ef13a99c98e082bd3ef1f6bd237f47ce7f0654e7363e0c9',
       i686: 'e7d216ea639aaf0647f1ab4b1984270ed32507b28c79115697fa60f4e080737e',
     x86_64: 'c06d06c190004346285fac3228c3fb46f36e03227be864a01df58a6c4e367d11'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
