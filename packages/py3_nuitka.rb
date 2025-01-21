require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.6-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f0375b52e6d1282f7f6b622ceb1154231fc72603a98f3bc26c94413e95646f40',
     armv7l: 'f0375b52e6d1282f7f6b622ceb1154231fc72603a98f3bc26c94413e95646f40',
       i686: '14842f3328d7df3a8db1a3b0c97d3b23345ef0604500371cbc13169fdfdae199',
     x86_64: '6233c898ca35675f2dd98995e615dd5455daa58701bd65c444307e10fb7786af'
  })

  depends_on 'python3' => :build

  no_source_build
end
