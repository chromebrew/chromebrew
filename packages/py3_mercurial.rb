require 'buildsystems/pip'

class Py3_mercurial < Pip
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version '6.8.1'
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2ae078a667d9fd2fa0d97b7ccca18ea5063e10a5ea21c53034f5a83096db069e',
     armv7l: '2ae078a667d9fd2fa0d97b7ccca18ea5063e10a5ea21c53034f5a83096db069e',
     x86_64: '836782430ef43bedd4794b76251a976272a6847fb8a3b488d4c35950e79ed6f1'
  })

  no_source_build

  depends_on 'buildessential' => :build
  depends_on 'glibc' # R
  depends_on 'py3_docutils' => :build
  depends_on 'python3' # L
  depends_on 'texinfo' => :build
end
