require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.6.3-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0fd39e4ed2fc129a4c534df95038e836e17ff16c07028e40105162215f35db5a',
     armv7l: '0fd39e4ed2fc129a4c534df95038e836e17ff16c07028e40105162215f35db5a',
       i686: '41f1e67449aec45820d8e3975ef6cd5ca39a1be0cf2f55ac0aad8b671f54dfc3',
     x86_64: '7857e2808b67f69ea284e92708402d3362e5212f6562b38474f25c2155e023bb'
  })

  depends_on 'python3' => :build

  no_source_build
end
