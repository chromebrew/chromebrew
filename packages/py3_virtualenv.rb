require 'buildsystems/pip'

class Py3_virtualenv < Pip
  description 'Virtualenv is a Virtual Environment builder for Python.'
  homepage 'https://virtualenv.pypa.io/'
  version "20.32.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '02abf9e6c4b078e4084dcd6a303b244cd264bceb0e1e0ee5993299df78898189',
     armv7l: '02abf9e6c4b078e4084dcd6a303b244cd264bceb0e1e0ee5993299df78898189',
       i686: '6e182ff8037127a065af856c12218e2367601f94bd39a8b449e80d9ed7df618a',
     x86_64: 'b67ccc99a08b11c6d41297b17ab1cc61b51bb9cdca7656f2045cebd89ed4468c'
  })

  depends_on 'py3_distlib'
  depends_on 'py3_platformdirs'
  depends_on 'py3_six'
  depends_on 'python3' => :build

  no_source_build
end
