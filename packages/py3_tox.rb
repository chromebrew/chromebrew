require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.64.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6142fa0592932ca78284734540aaf988226a6dd36d7f8b6fdae1e1d17615b5ae',
     armv7l: '6142fa0592932ca78284734540aaf988226a6dd36d7f8b6fdae1e1d17615b5ae',
       i686: '0602d102231ef318846bed4acf216e1a730ef6073283b67fca740d4739cb5ca2',
     x86_64: '553e64f869746ccd099547c820338c0c2415e7cf78023f7fdf67e36353d2b33c'
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
