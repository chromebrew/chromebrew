require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.60.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6a181c3defc040189eb1c51ed4c76d7f2fbbd6f042f4a163044e47759b90cd5d',
     armv7l: '6a181c3defc040189eb1c51ed4c76d7f2fbbd6f042f4a163044e47759b90cd5d',
       i686: '882906b5fa4dd3cf52d037ae4b9814fd7f1d886ca26fe518aa3815833dea0c86',
     x86_64: '51eaaf0fb412700c7a7ddd4446070ebc626db3de2823ccaeb737f064eacba1f9'
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
