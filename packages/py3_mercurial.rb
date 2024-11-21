require 'buildsystems/pip'

class Py3_mercurial < Pip
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version "6.9-#{CREW_PY_VER}"
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '49f5e6fdb47daf483adcf0c0ddc4fde0568da162daa3bf0f7983fd556b90ffa1',
     armv7l: '49f5e6fdb47daf483adcf0c0ddc4fde0568da162daa3bf0f7983fd556b90ffa1',
     x86_64: '9336f0f7dc2900d78bc218189ff2398c04ab2d94142fcd8ee996a795efe35d84'
  })

  no_source_build

  depends_on 'buildessential' => :build
  depends_on 'glibc' # R
  depends_on 'py3_docutils' => :build
  depends_on 'python3' # L
  depends_on 'texinfo' => :build
end
