require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.8-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c575620f84588b911d012c4fe781cf62b7da06d3a6938903372fe9dba5a4da47',
     armv7l: 'c575620f84588b911d012c4fe781cf62b7da06d3a6938903372fe9dba5a4da47',
       i686: '053fe3b79ae0bbc91901f10ac5174891bc7b08ed293c6895e690cb30be9b5cf9',
     x86_64: '9958bbf00c1e25e004499faee461677c8f42e666147ed309215545c4112a824c'
  })

  depends_on 'python3' => :build

  no_source_build
end
