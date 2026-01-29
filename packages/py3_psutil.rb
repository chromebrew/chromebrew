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
    aarch64: '0ccf41aea4cf453afba0a11e6c51d37ae5e030d30b674764ca65227693441dad',
     armv7l: '0ccf41aea4cf453afba0a11e6c51d37ae5e030d30b674764ca65227693441dad',
       i686: '5324465a2ee4c2d99cce18c742944ba4c1a26ff0913d6dce0c432b3256bce79c',
     x86_64: '28465bc392b6e5d703b13c0646cf38a585763e559614c1384c91ecec92510473'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
