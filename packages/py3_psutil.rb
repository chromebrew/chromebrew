require 'buildsystems/pip'

class Py3_psutil < Pip
  description 'psutil is a cross-platform library for process and system monitoring in Python.'
  homepage 'https://github.com/giampaolo/psutil/'
  version "7.2.0-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ff997e05f08f1f40b9b8056d2b60b9f7846ba4dca9ca9589dc62cbdf324c9b99',
     armv7l: 'ff997e05f08f1f40b9b8056d2b60b9f7846ba4dca9ca9589dc62cbdf324c9b99',
       i686: 'b3465fadace16e25978999e61028bcbf48f7d52c82dec3762fc4141ee140c418',
     x86_64: 'b84252a10fb602931c5c7c5c7f3de043dc26e4a025659b8dc06d7070300b3665'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
