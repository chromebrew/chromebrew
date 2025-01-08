require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.5.9-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f0375b52e6d1282f7f6b622ceb1154231fc72603a98f3bc26c94413e95646f40',
     armv7l: 'f0375b52e6d1282f7f6b622ceb1154231fc72603a98f3bc26c94413e95646f40',
       i686: '953b5c0bc34c3889f47965b79f2cd25986b7237a22f8c2a5184340bdcabdf6d2',
     x86_64: 'db7ff6ab8b7e54372668a12acd7c3ec0c7899051eff0dd1350d07ead34663fb6'
  })

  depends_on 'python3' => :build

  no_source_build
end
