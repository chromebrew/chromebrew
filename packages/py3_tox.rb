require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.53.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0723e75fb79145adb3fe7255db9c3c7fc376a7ccd55ec62d1db6daa7d1c50c7e',
     armv7l: '0723e75fb79145adb3fe7255db9c3c7fc376a7ccd55ec62d1db6daa7d1c50c7e',
       i686: '364526c17fe7f72d1fb3dbca4b1216bf42e4895fadf2c81ebe84abcad121bd4d',
     x86_64: '8906fd1127e1ab7d11afce7a3d3d9155df8e19b6b04509e74ddd59744eb7d6ad'
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
