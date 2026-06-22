require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "4.1.3-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cb94cebf503364c26353ca71c85a84029619a0a873c47412f00826445ea2fbf6',
     armv7l: 'cb94cebf503364c26353ca71c85a84029619a0a873c47412f00826445ea2fbf6',
       i686: '02b0d458e8734b7ca49e4c0c3965d8f2b6482751c12ae12320052434b8995cee',
     x86_64: '05d1772d80ec2c1b7f548e0036a6b07a0f00b7942526d5fc7660a9cd988e67fb'
  })

  depends_on 'python3' => :logical

  no_source_build
end
