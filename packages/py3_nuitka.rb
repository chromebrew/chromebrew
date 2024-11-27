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
    aarch64: 'c783498535425968ba5c8c0d77b78cdfaac29356c6615bd5d8368f5b17df2a0b',
     armv7l: 'c783498535425968ba5c8c0d77b78cdfaac29356c6615bd5d8368f5b17df2a0b',
       i686: 'fa883dc6dfe75b2abb8155106408b7c0f3b556ea118818a1095c1e07a9379334',
     x86_64: 'e65c64f0f18db31e3ef231d24baafe07a854340a9df9f030464cd1e74355e668'
  })

  depends_on 'python3' => :build

  no_source_build
end
