require 'buildsystems/pip'

class Py3_mercurial < Pip
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version "6.9.3-#{CREW_PY_VER}"
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ea70b97bd8d0810f00cbd1f7fdbe91554eb93d1ca1b74a62f2ad5e910f5546a3',
     armv7l: 'ea70b97bd8d0810f00cbd1f7fdbe91554eb93d1ca1b74a62f2ad5e910f5546a3',
     x86_64: '6fb59fcdd1bd1f7f4effae562023c7114b775080921f2d6ddd5023ed8a9d91d2'
  })

  no_source_build

  depends_on 'buildessential' => :build
  depends_on 'glibc' # R
  depends_on 'py3_docutils' => :build
  depends_on 'python3' # L
  depends_on 'texinfo' => :build
end
