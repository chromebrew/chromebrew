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
    aarch64: 'f95a0358345de533bcedb79390c2339b7fe8235e6f9d2b5cfecc445f60c468b0',
     armv7l: 'f95a0358345de533bcedb79390c2339b7fe8235e6f9d2b5cfecc445f60c468b0',
       i686: 'fa883dc6dfe75b2abb8155106408b7c0f3b556ea118818a1095c1e07a9379334',
     x86_64: '86fad97cef4640cfaa949060ea45c129d9e01ed76c75143dd514dad6d65d2e87'
  })

  depends_on 'python3' => :build

  no_source_build
end
