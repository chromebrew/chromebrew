require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.7.9-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2dab495205842f63572034e7bf694befdae077325747be55d167ff3c066c7899',
     armv7l: '2dab495205842f63572034e7bf694befdae077325747be55d167ff3c066c7899',
       i686: '71cd00f789cf941e40c4e550acb1bf26cf820c8f40b500208c0541a924b60f1a',
     x86_64: 'a4b5f6932d7a495929e0e8ac003614aba6430cb8658959f486876dc1e0e37abe'
  })

  depends_on 'python3' => :build

  no_source_build
end
