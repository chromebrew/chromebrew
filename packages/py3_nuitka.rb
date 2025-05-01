require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.7-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4aae52be0fc82d27b1030c0ffaabe252f263252841dedb7ad548d688bd251c11',
     armv7l: '4aae52be0fc82d27b1030c0ffaabe252f263252841dedb7ad548d688bd251c11',
       i686: '5abb26f28154d790a9b8c7af9d5364338b0084602fdddea62a22892af405848e',
     x86_64: '93f798b07fd9c79d73b3d81a56f2109ee7087f2e1d1c1129286ba616f06774fb'
  })

  depends_on 'python3' => :build

  no_source_build
end
