require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.26.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '834efc965c97b5de35ca7691468df8e252fb1c7d1c95281e96d957bb8eaec604',
     armv7l: '834efc965c97b5de35ca7691468df8e252fb1c7d1c95281e96d957bb8eaec604',
       i686: '0e80c936049fa36deb9b1ff69be1c6fd6b2ce291ff1137eda7b952fc7bef57ca',
     x86_64: '02fba8545ded1a7a3c64238665503a72a3ed01380c881e810b9743ce5f9fbf2d'
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
