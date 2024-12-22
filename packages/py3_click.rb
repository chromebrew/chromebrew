require 'buildsystems/pip'

class Py3_click < Pip
  description 'Click is a simple wrapper around optparse for powerful command line utilities.'
  homepage 'https://click.palletsprojects.com'
  version "8.1.8-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '176c87e87bdc23afb4ea063ad7e86a6f2ba16c84f817549245767f5db018d0db',
     armv7l: '176c87e87bdc23afb4ea063ad7e86a6f2ba16c84f817549245767f5db018d0db',
       i686: '006e9b6ba77331b2aefe16b0f5d35403e43b12031af5e322ece255c8928dd864',
     x86_64: '3402b43f2bf1b0febb3a711a5e8058fe0e31c92338df71af2e8a0629fe9cf0a2'
  })

  depends_on 'python3' => :build

  no_source_build
end
