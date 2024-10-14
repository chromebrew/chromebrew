require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.4.9-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '939747f1ce1d90ebc28225643fe5bd57d3442cca67687dd95e7737cb6170b98f',
     armv7l: '939747f1ce1d90ebc28225643fe5bd57d3442cca67687dd95e7737cb6170b98f',
       i686: '86df18d19fd4f12940f8647917e249a908713f03d98e6e4752ee13f746da98dc',
     x86_64: '9a14f4cf2f5c3e605b973472f740cc6edca5b2f4a71ab512a3d4f45348b864ae'
  })

  depends_on 'python3' => :build

  no_source_build
end
