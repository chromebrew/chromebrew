require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.6.6-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f796e8d7fb8be7626fee22fe8f3387e46c73bf84533492a4e0cee239d65d01ee',
     armv7l: 'f796e8d7fb8be7626fee22fe8f3387e46c73bf84533492a4e0cee239d65d01ee',
       i686: '509e08dde99c7889483b259b721e4a5594349ab19d70a3b02adb07fdf96803c5',
     x86_64: 'd1f8d40afdf9a83a2fe1556de8141cf22147fc450044610539de0cfe7f3af9fa'
  })

  depends_on 'python3' => :build

  no_source_build
end
