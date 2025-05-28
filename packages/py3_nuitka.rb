require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.7.4-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e92cc4bc2cefae32ea6b3ad174f6ab98065d3975a475126b7c9fdeb79a57b843',
     armv7l: 'e92cc4bc2cefae32ea6b3ad174f6ab98065d3975a475126b7c9fdeb79a57b843',
       i686: '46528f958f04c7bbe9519cc403fa16869a2cc818d0631746f9865fe84c3eefc8',
     x86_64: '8d86a6d334db0408fe5d7241e8610e5761fd3f566ab9080af79a0b1f396dddac'
  })

  depends_on 'python3' => :build

  no_source_build
end
