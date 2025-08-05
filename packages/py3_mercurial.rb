require 'buildsystems/pip'

class Py3_mercurial < Pip
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version "7.1-#{CREW_PY_VER}"
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f103d6611491fefd04d09d4e9e82f093cdb283cda18924c294aa02003f101dd1',
     armv7l: 'f103d6611491fefd04d09d4e9e82f093cdb283cda18924c294aa02003f101dd1',
     x86_64: 'b03aa29b09e37d02ec00445362b6671da927a6d9a6fa1ac87a89947b3df721b5'
  })

  no_source_build

  depends_on 'buildessential' => :build
  depends_on 'glibc' # R
  depends_on 'py3_docutils' => :build
  depends_on 'python3' # L
  depends_on 'texinfo' => :build
end
