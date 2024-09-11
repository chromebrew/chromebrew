require 'buildsystems/pip'

class Py3_mercurial < Pip
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version '6.8.1-py3.12'
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3876f682d184e078c3ff43640de7045632732e9010f81701cba0ee96a6a7b95a',
     armv7l: '3876f682d184e078c3ff43640de7045632732e9010f81701cba0ee96a6a7b95a',
     x86_64: '7f7765912cb56b023e67797acea04da63b5f09509fd9a6ad3ed92a3343fc4b06'
  })

  no_source_build

  depends_on 'buildessential' => :build
  depends_on 'glibc' # R
  depends_on 'py3_docutils' => :build
  depends_on 'python3' # L
  depends_on 'texinfo' => :build
end
