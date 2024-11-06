require 'buildsystems/pip'

class Py3_mercurial < Pip
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version "6.8.2-#{CREW_PY_VER}"
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ce263a5028b5bf45ed365fad1d70537fbaf6d87e7a45b78ed15595a5288a7d07',
     armv7l: 'ce263a5028b5bf45ed365fad1d70537fbaf6d87e7a45b78ed15595a5288a7d07',
     x86_64: '25d5269c05f150e4a6339901a3ad21f8e028e7b4bdf7f645c32cb496cc170d08'
  })

  no_source_build

  depends_on 'buildessential' => :build
  depends_on 'glibc' # R
  depends_on 'py3_docutils' => :build
  depends_on 'python3' # L
  depends_on 'texinfo' => :build
end
