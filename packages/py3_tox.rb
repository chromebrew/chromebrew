require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.61.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1ad9dd5a019cba17647656ed900b64c05722486959278f50933ba8f6cb8621d3',
     armv7l: '1ad9dd5a019cba17647656ed900b64c05722486959278f50933ba8f6cb8621d3',
       i686: '3990f7a1b043451eef0021c00f65b05473c737a25c398014e085430442729092',
     x86_64: '453b876403ef7d80b346455f535dece4ac45c1a023ff76cd24347bab60c73343'
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
