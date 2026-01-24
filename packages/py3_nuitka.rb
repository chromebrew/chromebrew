require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.8.10-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9565c1bbb0fcf27b113f1d0a84b1c158bf24880ed88252703ebfa24893679923',
     armv7l: '9565c1bbb0fcf27b113f1d0a84b1c158bf24880ed88252703ebfa24893679923',
       i686: '589a155d2770795e4003a0aba02aea8386d3eedbc1f104e2a548795ab4e649c3',
     x86_64: '393b59f24825b6825f6f42529ed7bcfdf1758fa88e0e1a235d493bff9fc7990c'
  })

  depends_on 'python3' => :build

  no_source_build
end
