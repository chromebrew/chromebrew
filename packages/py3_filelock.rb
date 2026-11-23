require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.3.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '67845bf8568217c52171e08354b6a35535e6390c63f56b6aea94fc74ea66fac4',
     armv7l: '67845bf8568217c52171e08354b6a35535e6390c63f56b6aea94fc74ea66fac4',
       i686: 'a4d914ab7014ad68f22a321197ee7eb540ab30372e2cb4212156ea23784f7237',
     x86_64: 'cb5d233195795373ff859d7d0a6041036eff417481818c08672c304be438a3ea'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
