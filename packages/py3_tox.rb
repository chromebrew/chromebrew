require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.23.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '671519ba2a447ee4d95965f55f0bbcf0d08ce808edd33b02457a2aa9e6fa17b1',
     armv7l: '671519ba2a447ee4d95965f55f0bbcf0d08ce808edd33b02457a2aa9e6fa17b1',
       i686: 'fde76e29fcd8e371ee98bf88a6d70a527ce910b357f13c6942e46797fa0e1e56',
     x86_64: '85bbb91ef2e9508f2388ff350165a72e7fabd0e7af6bb7ca587620aac4a98bdf'
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
