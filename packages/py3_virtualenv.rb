require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.27.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2996ceb5a2fee53c9f979ad8e0d70340e5e773cf082303c64e14b19b823d2d9b',
     armv7l: '2996ceb5a2fee53c9f979ad8e0d70340e5e773cf082303c64e14b19b823d2d9b',
       i686: '696a9fb03515ae43e85192b5063fef41583b58123972454659c4de488f7d407e',
     x86_64: 'ea8fc4908f77a8fe1cdb3e15524677733bd16a969995c8dc6e177e70f6b5178a'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
