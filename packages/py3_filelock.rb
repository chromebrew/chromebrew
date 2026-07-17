require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "3.30.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ebe12a8b00a2b97d9a12458a7bb7b76c9d3cecf1cf21aeaaf4e259a0ccd8f821',
     armv7l: 'ebe12a8b00a2b97d9a12458a7bb7b76c9d3cecf1cf21aeaaf4e259a0ccd8f821',
       i686: '587e63df4a8bf8b62f68ba5e602b3d5c721bcb9cd311dddf743e0e6f86c4c341',
     x86_64: '99c76f6d5c41a2ba563fc71713539565234728d714bcb1dab8d5d8f0f3290503'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
