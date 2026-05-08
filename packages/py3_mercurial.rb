require 'buildsystems/pip'

class Py3_mercurial < Pip
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version "7.2.2-#{CREW_PY_VER}"
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '82cb0a9d71b0d4e653c819693e58b1d07165bd037fd3f7239d1af6a5a0d21395',
     armv7l: '82cb0a9d71b0d4e653c819693e58b1d07165bd037fd3f7239d1af6a5a0d21395',
     x86_64: 'd4a81cf629dea20d74850214ecdf69aa0164425ab808eb0a3a02ed0600141d99'
  })

  depends_on 'buildessential' => :build
  depends_on 'glibc' => :library
  depends_on 'py3_docutils' => :build
  depends_on 'python3' => :logical
  depends_on 'texinfo' => :build

  no_source_build
end
