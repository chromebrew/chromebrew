require 'buildsystems/pip'

class Py3_tox < Pip
  description 'Command line driven CI frontend and development task automation tool.'
  homepage 'https://tox.readthedocs.io/'
  version "4.55.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5078e5311f85c1a3e90306410c63eaf9fb7bcee0f02a77e0bd62ed223710660c',
     armv7l: '5078e5311f85c1a3e90306410c63eaf9fb7bcee0f02a77e0bd62ed223710660c',
       i686: '35c9d8ea650ef09318d974617be6250030d5e7ca6e5545e1fba8a0252d35d987',
     x86_64: '899832a2249a08d039045d7ee2761b9284e2ffe2c07098adfc8c27cf1f2a6910'
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
