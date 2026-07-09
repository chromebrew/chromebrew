require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "3.29.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e02ac63bb6fddcf0465f9dd248067d09e48abe4ca2491e41adad7ba57c00cabb',
     armv7l: 'e02ac63bb6fddcf0465f9dd248067d09e48abe4ca2491e41adad7ba57c00cabb',
       i686: '4525bb753a738a426c2585288e3bb184ae07715115d3649a302649b467dff236',
     x86_64: '3b2afea4ca5f6a0d9e9ed50350951e070626827caa421b20d7e7c9e952007905'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
