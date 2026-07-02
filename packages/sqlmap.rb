require 'buildsystems/pip'

class Sqlmap < Pip
  description 'sqlmap is an open source penetration testing tool that automates the process of detecting and exploiting SQL injection flaws and taking over of database servers.'
  homepage 'https://sqlmap.org/'
  version "1.10.7-#{CREW_PY_VER}"
  license 'GPL-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3cf9d826a0c01d2d071fe0c83fe4d726231d538b3a402c28fcd3fd5f18a4e4f4',
     armv7l: '3cf9d826a0c01d2d071fe0c83fe4d726231d538b3a402c28fcd3fd5f18a4e4f4',
       i686: '9a79dcdd44bfbe1b4eab65d8716dac72f903ac337c180c2f6ef9cf55e0cfbd76',
     x86_64: '47c8e0ba8cda2464ee7661918d87b5abce29604e865d29fdcad03247032a0a82'
  })

  depends_on 'python3' => :logical
  depends_on 'python3', '>= 3.12.0'

  no_source_build
end
