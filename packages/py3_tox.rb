require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.21.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '575c592c6781acfdca0586a2b0b760fd6ef697461669c45fcdb1412ba49d377c',
     armv7l: '575c592c6781acfdca0586a2b0b760fd6ef697461669c45fcdb1412ba49d377c',
       i686: '01e51d11ed7e665792f12b4d9e1f08e9d29f6aa41f896d4f3341c5a4b3e59712',
     x86_64: 'e0999c9eda80d8717beaf3d7c7b2f325a8b1c3d445b153109179f518a7408894'
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
