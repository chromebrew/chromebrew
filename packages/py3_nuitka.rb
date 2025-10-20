require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.8.3-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4cf2626f31370592aa577e70714269dc3694f2d1195973735e15f60085dfcd66',
     armv7l: '4cf2626f31370592aa577e70714269dc3694f2d1195973735e15f60085dfcd66',
       i686: '916481ae2752b5df09bc3d5a9b5cd5490e1bacd46c7c0033f0b24fb1161caa82',
     x86_64: 'c0e0a0c70e0893296fdf5c7421bc34b6afabc02bf5adcb1e128f04eecaa13980'
  })

  depends_on 'python3' => :build

  no_source_build
end
