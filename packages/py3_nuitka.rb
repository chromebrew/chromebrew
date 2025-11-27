require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.8.8-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4fdaf278277914126dbbdfff389d8a5c50f68b06dac0ce4adfe380c4ddbb2d47',
     armv7l: '4fdaf278277914126dbbdfff389d8a5c50f68b06dac0ce4adfe380c4ddbb2d47',
       i686: '0f5e6dc33f433924dc9fc908fdd7e71870cb02a6dec58c860d85536cc0265603',
     x86_64: 'e208a9d54243903df12ec53a683004b7c612c1f5c5d453f636e4c6fea7c9b994'
  })

  depends_on 'python3' => :build

  no_source_build
end
