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
    aarch64: 'f97141b76025bb29c8d26126e2def115a12e28b316b2d6f1fcd5d7751efbb9db',
     armv7l: 'f97141b76025bb29c8d26126e2def115a12e28b316b2d6f1fcd5d7751efbb9db',
       i686: '12ec76ff3b9e4ba42bd0406720d16497acad19372722ac82780b0a0ac94afa2d',
     x86_64: '5b30d84fc977b80565bfec482fce34465122ec21bf7d59ad67d245f430b7fe2f'
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
