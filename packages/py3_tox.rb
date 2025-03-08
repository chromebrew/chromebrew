require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.24.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c3b71c81c64df01c60f5414a521ddf60f995eb2f666667071529047f9631ee24',
     armv7l: 'c3b71c81c64df01c60f5414a521ddf60f995eb2f666667071529047f9631ee24',
       i686: '3fa67cf01e2025c94d1c67b4ff6a8dc058f79e4c0dfe38fca475d360d58bbc5e',
     x86_64: 'c67f148dece1ab0f4a039d89664139fbe47aa3445eb6ba015882241d43d7869d'
  })

  depends_on 'py3_py'
  depends_on 'py3_filelock'
  depends_on 'py3_six'
  depends_on 'py3_packaging'
  depends_on 'py3_virtualenv'
  depends_on 'py3_pluggy'
  depends_on 'py3_toml'
  depends_on 'python3' => :build

  no_source_build
end
