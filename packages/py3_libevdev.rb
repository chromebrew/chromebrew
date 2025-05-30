require 'buildsystems/pip'

class Py3_libevdev < Pip
  description 'Libevdev is a Python wrapper around the libevdev C library.'
  homepage 'https://python-libevdev.readthedocs.io/'
  version "0.12-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ba2b93033f7487dd92f00be5347b0c1587193b3d0813c3c2531e1242e749fe91',
     armv7l: 'ba2b93033f7487dd92f00be5347b0c1587193b3d0813c3c2531e1242e749fe91',
       i686: '954789cc502589668460813e32da86b9b4a57bfe991d73dc4fd46e1033976253',
     x86_64: '26c8dbcf65e3fea19203a2b1f9bba5ffa93e5c037b09a1afd20500348212775d'
  })

  depends_on 'python3' => :build

  no_source_build
end
