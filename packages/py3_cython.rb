require 'buildsystems/pip'

class Py3_cython < Pip
  description 'The Cython language makes writing C extensions for the Python language as easy as Python itself.'
  homepage 'https://cython.org/'
  version "3.1.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '22e60b598705ae694e5869e59f0bf3f114cada507ff825ee06ccb3c83122971c',
     armv7l: '22e60b598705ae694e5869e59f0bf3f114cada507ff825ee06ccb3c83122971c',
       i686: '1506fdf6e57c617390606290aa88e3126d794da93c4c623a0d81f9cb42b406ad',
     x86_64: '5bb5a4740edf30e890ac0097a7d32012b63480c25d1d5a509d3e42fdee499822'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
