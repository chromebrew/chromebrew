require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.2.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2451e3a59295fe487eb91f057d0e8bea572ea2e0622f6c8d8136224340feda36',
     armv7l: '2451e3a59295fe487eb91f057d0e8bea572ea2e0622f6c8d8136224340feda36',
       i686: '96fa0ff6307c4d250501a79e9e88ec82a2641344090c68854c48d68540dc5d00',
     x86_64: '90a233264cd88ca48d6b1c710f883116633f936768605d35947c52d8f079ece6'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
