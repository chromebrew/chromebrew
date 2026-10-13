require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.65.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6f9b9729855cb3729868d5d5f011caf64aa38d558d8b4f61948c91911b374441',
     armv7l: '6f9b9729855cb3729868d5d5f011caf64aa38d558d8b4f61948c91911b374441',
       i686: 'c34f911e61c05aa7a46cded96ab8def3579893cefd28aa12495844bfca73d1b2',
     x86_64: '623d2b4bc638e03d663accb5b0d79d6eeff5d76cdededf67acde97b4807cb5f6'
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
