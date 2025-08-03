require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.28.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7d66ab5e92db30959a43b8340acf6185c660be33b4476110efc0a23a33f4f09e',
     armv7l: '7d66ab5e92db30959a43b8340acf6185c660be33b4476110efc0a23a33f4f09e',
       i686: '6c22ffdede48422d4360f033c67f245b4e88eb0a5b35af55a0679d7d69144182',
     x86_64: 'cb608b5620c15018cecc58d7e848c00c0302708ca704b66e52b9492c4dcfac82'
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
