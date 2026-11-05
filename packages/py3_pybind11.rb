require 'buildsystems/pip'

class Py3_pybind11 < Pip
  description 'Seamless operability between C++11 and Python'
  homepage 'https://github.com/pybind/pybind11'
  version "3.1.0-#{CREW_PY_VER}"
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3d6cb27aa87ef4383cc19659136b5ade0bbd13616c741894ff541b621b58c87a',
     armv7l: '3d6cb27aa87ef4383cc19659136b5ade0bbd13616c741894ff541b621b58c87a',
       i686: 'c86e4571d81cac26ded0ab1791f1141aee1882f8dcc06b20fbd7d784316c7f6b',
     x86_64: 'bd8596e87843aaa304c66e08f5f01a65613edb366a20abfd408b4de79d604e5d'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
