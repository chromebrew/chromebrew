require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.60.1-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dd99fe43f31a2192f4c333e0dbace0e3e0a948f1849d0637b635cd58d2b15a97',
     armv7l: 'dd99fe43f31a2192f4c333e0dbace0e3e0a948f1849d0637b635cd58d2b15a97',
       i686: '195972583516ef35c38459350326009a511ab33cb6760710905e30ef874cb949',
     x86_64: 'a0ff4ac31f6c8d6d90a559fcf5f15f9e6f3d15ba4c317c26e1cfb1fa1d402c27'
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
