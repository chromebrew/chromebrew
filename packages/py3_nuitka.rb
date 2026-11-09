require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "4.3.5-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3e15cada00d0aa34da4bc0b55b76e363c7eeed2f04cdd38729fb4bf1d968487d',
     armv7l: '3e15cada00d0aa34da4bc0b55b76e363c7eeed2f04cdd38729fb4bf1d968487d',
       i686: 'bbac45696e573fe8d00e65589a1b7c5a3dc79ec2e4ccd36f63684fa40dbdc5a3',
     x86_64: '683a4d5c52e97219379bcca7fe295ce8962daefed286a32343d7d9c3cb639703'
  })

  depends_on 'python3' => :logical

  no_source_build
end
