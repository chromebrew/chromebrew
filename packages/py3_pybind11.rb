require 'buildsystems/pip'

class Py3_pybind11 < Pip
  description 'Seamless operability between C++11 and Python'
  homepage 'https://github.com/pybind/pybind11'
  version "3.0.1-#{CREW_PY_VER}"
  license 'BSD-3 Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9d1a2f100a39ff66e4a69af1d8d24f32e514b321441ad66ac716928bf6314dd5',
     armv7l: '9d1a2f100a39ff66e4a69af1d8d24f32e514b321441ad66ac716928bf6314dd5',
       i686: 'ffd2c3fe9f3546511f7a3ed7489ff59184e2f349e2798a6cf3fcd35396893064',
     x86_64: '7c6a2a42b332fe6110e0e75ffc79c2e3a38e6cbd79faed75bbaefa1d41cc5c42'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
