require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.61.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8be9c74e6f2b96c7cddcf28dd0b8cbc6a90229eeb022b9188c97fa926a29a245',
     armv7l: '8be9c74e6f2b96c7cddcf28dd0b8cbc6a90229eeb022b9188c97fa926a29a245',
       i686: 'fa44b5521bc5527495a0ac6c7ce5f59d890dce87627651a4170f618aa8d389f0',
     x86_64: '92b566cf43f8f6ad0a995371909813f02b0602bb7daf8aba30c0f7f88ce16f25'
  })

  depends_on 'py3_filelock'
  depends_on 'py3_packaging'
  depends_on 'py3_pluggy'
  depends_on 'py3_py'
  depends_on 'py3_six'
  depends_on 'py3_toml'
  depends_on 'py3_virtualenv'
  depends_on 'python3' => :logical

  no_source_build
end
