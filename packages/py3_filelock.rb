require 'buildsystems/pip'

class Py3_filelock < Pip
  description 'FileLock implements a platform independent file lock in Python.'
  homepage 'https://github.com/tox-dev/filelock'
  version "3.29.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02477b987421493a0ba758b5421b56b3736425f5bb17c522e9a273f51a513521',
     armv7l: '02477b987421493a0ba758b5421b56b3736425f5bb17c522e9a273f51a513521',
       i686: '7d13c7379a6184caf422e7e7ed631097da8e799ac548112a81d40265669dd51e',
     x86_64: '8b4c321c8bdba579323871f65eb7b05a4384612ab6a5740f944c94a1f92ddae3'
  })

  depends_on 'py3_python_discovery' => :logical
  depends_on 'python3' => :logical

  no_source_build
end
