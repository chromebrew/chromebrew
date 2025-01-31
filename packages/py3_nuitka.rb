require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.6.2-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0fd39e4ed2fc129a4c534df95038e836e17ff16c07028e40105162215f35db5a',
     armv7l: '0fd39e4ed2fc129a4c534df95038e836e17ff16c07028e40105162215f35db5a',
       i686: '7aa5df5edf567170d35daeb0667b220bd6e513c9c9fa4924516e205de7da5877',
     x86_64: 'cfa19215eac06dcbbc887b2d240fe606c2fd092634c56ee61af7db42a4b742ec'
  })

  depends_on 'python3' => :build

  no_source_build
end
