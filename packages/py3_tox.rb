require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.56.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f20eb3ed2c6e05c7fe84dda39d0a7bf8f61ae3a97be801c123a30e48fc202ea5',
     armv7l: 'f20eb3ed2c6e05c7fe84dda39d0a7bf8f61ae3a97be801c123a30e48fc202ea5',
       i686: '5f5fac7913b6e976eeabd6d203127866a49f766fbfa1af945ab4f2b570b71d85',
     x86_64: '42d78ea77a7e68f5443d344dc0268c1a835dbf44b515983987946c062a96d50b'
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
