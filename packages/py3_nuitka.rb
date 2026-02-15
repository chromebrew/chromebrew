require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "4.0.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '10e0b948760d98b1e3bbac764638f04140188cdc395aa9c0f0f1e9d3ecc919f1',
     armv7l: '10e0b948760d98b1e3bbac764638f04140188cdc395aa9c0f0f1e9d3ecc919f1',
       i686: '1c3853ee28c39147928c732f7ea1f3a48f45126472c6c347bd6dca9d5ab5a56b',
     x86_64: '30c842ef339d29a51b0a53b0f460836132fd55231355505aac13e3f650b5d747'
  })

  depends_on 'python3' => :build

  no_source_build
end
