require 'buildsystems/pip'

class Py3_psutil < Pip
  description 'psutil is a cross-platform library for process and system monitoring in Python.'
  homepage 'https://github.com/giampaolo/psutil/'
  version "7.2.2-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0018fc963ef0afe8395753816767872df009c1bf923e3c925d2325a3de340d80',
     armv7l: '0018fc963ef0afe8395753816767872df009c1bf923e3c925d2325a3de340d80',
       i686: '6a8810293a6e0fc7e26c8ac662abaa6e9735f90f7bd405fd2261aa438de5b37a',
     x86_64: 'b9f371b43975483c8b429dfdd9c22508b928dd6f5423b0bea1079605d6b6c65b'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
