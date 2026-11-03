require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.67.7-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8228291e8f31b1dca6823457c986c72adc63ec6355b3d463f4d7f8c768a8d39f',
     armv7l: '8228291e8f31b1dca6823457c986c72adc63ec6355b3d463f4d7f8c768a8d39f',
       i686: 'abff31f75b8c2f7263937c0e5706254e3bbe1ace67f3ea39944e458de315ce64',
     x86_64: '75d5de555ae53a10050f3fab5ace773c040d412cf7b82f269de3756ca0b9ea36'
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
