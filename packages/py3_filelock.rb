require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "4.1.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5b6a615fb36f281223431e2e11d6a6ab6cd95a2f1b46d89fc1392b354080000c',
     armv7l: '5b6a615fb36f281223431e2e11d6a6ab6cd95a2f1b46d89fc1392b354080000c',
       i686: 'be6d2abe342c04c5d743bc3f326d218b2f884ffa9aca8dcf4062c595a0661fce',
     x86_64: 'd3c794ac865274ce129c13f98ce78eca462d4075deaae42365e003ec462a73dd'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
