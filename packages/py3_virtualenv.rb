require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "21.15.6-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fa87b4e08b4ffb42fcdfd7a34077170d4e77e0024e56644a5619728a2b44e01b',
     armv7l: 'fa87b4e08b4ffb42fcdfd7a34077170d4e77e0024e56644a5619728a2b44e01b',
       i686: 'dc3f58f2893a1630e4c0d930a40ac45d93e74f9e92f68720d1ad345ace939ac0',
     x86_64: 'f88f5fabde25fb7b73c78a5427f43a3650312c00f23088d03e6e6234ee7dfaa8'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :logical

  no_source_build
end
