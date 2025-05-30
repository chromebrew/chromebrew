require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.7.5-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c410916b27e5666c8c14c0bb96c8557a13faabd24179856c517485a7c9d96292',
     armv7l: 'c410916b27e5666c8c14c0bb96c8557a13faabd24179856c517485a7c9d96292',
       i686: 'c3d1bfc97f28486c55082f9fd1d1d6a9caac9d7a3bb265f310c6d29e35972a93',
     x86_64: 'af1b121273c4e3dcea132047e5aa9de626e9aad92e330576f307cf81cd9f239e'
  })

  depends_on 'python3' => :build

  no_source_build
end
