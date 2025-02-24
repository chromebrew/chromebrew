require 'buildsystems/pip'

class Py3_nuitka < Pip
  description 'Nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version "2.6.7-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f4dd79f623e82456d58bef8193417bc457b4b78de70b793009d6fd5effb6daae',
     armv7l: 'f4dd79f623e82456d58bef8193417bc457b4b78de70b793009d6fd5effb6daae',
       i686: '39975ef65be10071be2796062a1abe68301622104cf2bd7b98202e2693e8d67c',
     x86_64: '2d0a82903b720415f6bc27bcc16269c6f76cff076d895d5518851a64e6cea9e5'
  })

  depends_on 'python3' => :build

  no_source_build
end
