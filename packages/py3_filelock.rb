require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.1.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1f72e97206ce2690de9666362702520da5f4d8461b1a9953ee798fa2e94a2016',
     armv7l: '1f72e97206ce2690de9666362702520da5f4d8461b1a9953ee798fa2e94a2016',
       i686: '538a1838386b4ad60c76c6d8c5da11e427a3656691ff25d84cc5a36f1c714d56',
     x86_64: 'caf5a5ec7aed2b52eea9a1082951c43f2e0a105eadd35082e0b0961cd3e05f8b'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
