require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.64.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '29fdef88e5424368d19d1c58d6499bd7d04e522f5e31c03302723c248a6f43aa',
     armv7l: '29fdef88e5424368d19d1c58d6499bd7d04e522f5e31c03302723c248a6f43aa',
       i686: 'f4150ce9ec7f80ad7ce1ef969cb81f1fe87499514e5fef9bbfca96caf75b7ade',
     x86_64: '95aa33ab892e7852ffad211bd148611af4127a50d044f38a92ca0bf1bd0b0a14'
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
