require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.5.4-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8182d0abfc961133ae58f770d7a470d169b263c42ff8859cccd992e3d2d602de',
     armv7l: '8182d0abfc961133ae58f770d7a470d169b263c42ff8859cccd992e3d2d602de',
       i686: 'fa883dc6dfe75b2abb8155106408b7c0f3b556ea118818a1095c1e07a9379334',
     x86_64: '37e7870822843659659d416e9dc6578a5d23d40f2ffd5abde25ae6d04cc791af'
  })

  depends_on 'python3' => :build

  no_source_build
end
