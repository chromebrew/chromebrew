require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "3.32.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9a0668c70d1838b070c68d7fa7eaa8d95c3b872cc33a64b300f4b8488dd9c636',
     armv7l: '9a0668c70d1838b070c68d7fa7eaa8d95c3b872cc33a64b300f4b8488dd9c636',
       i686: '3c893d3bed3a77b365d9fa453aca29eef665387eaa46dcb43c8ab5036a330104',
     x86_64: '5b817b443b3f638996ddf0ddae5fa873bcf3354dbb31de712d013686a93aeccd'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
