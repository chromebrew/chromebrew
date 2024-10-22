require 'buildsystems/pip'

class Py3_toml < Pip
  description 'Toml is a Python Library for Tom\'s Obvious, Minimal Language.'
  homepage 'https://github.com/uiri/toml/'
  version "0.10.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '60b30bd72dcf2a9cdb1dbfdc2244a7270fecd8b16ce48c7501e2a6a06b42dbeb',
     armv7l: '60b30bd72dcf2a9cdb1dbfdc2244a7270fecd8b16ce48c7501e2a6a06b42dbeb',
       i686: '2c3bc3d2f6b007064df1f03c3e2b336824792028602ea03990669ed8beaad35b',
     x86_64: '11ff69452d7b37c7082bd5f25575ba403dd9336df8e36d84f718bdf88f37ca0b'
  })

  depends_on 'python3' => :build

  no_source_build
end
