require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.67.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '187ebcfeaac15b049433c325edd2a08381c6685f2f5e04c2081261352596ceb7',
     armv7l: '187ebcfeaac15b049433c325edd2a08381c6685f2f5e04c2081261352596ceb7',
       i686: 'f9dbbf51997c3206db9fdf34ab087c33a6ff9504163b3a48526032ef473cfc4d',
     x86_64: '199a4a853bf5ca3e8d40f916fdbb3eb6365e308f462fbdd87b7dca9f051fe8bb'
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
