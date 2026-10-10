require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.65.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '79d730d1978c3dd5a04c826245f374b96ffae21b549794e758f8e75e00c7a302',
     armv7l: '79d730d1978c3dd5a04c826245f374b96ffae21b549794e758f8e75e00c7a302',
       i686: '80eb3e1d54e60241311409ef1f30ff170366cf3b6cfe57981dba5255b97b27db',
     x86_64: '0f7370da9c2594ef731839d9a2988a6364f3acc9b9adecb2b2288dc0c348ed60'
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
