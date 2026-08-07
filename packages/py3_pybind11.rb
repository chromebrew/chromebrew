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
    aarch64: '3d30aa60e204bad0c16f07093c8561c50ac0f2060a6afd0fc898c1bc8a08ecd8',
     armv7l: '3d30aa60e204bad0c16f07093c8561c50ac0f2060a6afd0fc898c1bc8a08ecd8',
       i686: '6635bd14a3a06f94d49943437ee962bd1220f1c2737498b2bfaa4bcf37b35d67',
     x86_64: '40c905a11add70f43d6abc6d63cd6c41a6aecb7007a2184da22a28cac4e34164'
  })

  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
