require 'buildsystems/pip'

class Py3_mercurial < Pip
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version '6.5.3'
  license 'GPL-2+'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ad9fdf69371c58c8b4a3a9a557ab5eaac6a67853ae9f5dc5425ebd823fa1e41b',
     armv7l: 'ad9fdf69371c58c8b4a3a9a557ab5eaac6a67853ae9f5dc5425ebd823fa1e41b',
       i686: '391928a642b2d0f201569e9b8f08bbcc1554befe83506148a06db4dd6a935930',
     x86_64: '651fa4cdc65f2bcec0517701b32088a50edb942cd18d136b7829eb403a6f5efe'
  })

  depends_on 'glibc' # R
  depends_on 'py3_docutils' => :build
  depends_on 'python3' # L
  depends_on 'texinfo' => :build
end
