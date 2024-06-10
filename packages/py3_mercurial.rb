require 'buildsystems/pip'

class Py3_mercurial < Pip
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version '6.7.3'
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '16fd75bc6e57d5053b7d050471fdca3272c3311dfac61ae3674de6268128f7f8',
     armv7l: '16fd75bc6e57d5053b7d050471fdca3272c3311dfac61ae3674de6268128f7f8',
     x86_64: 'ddc550c75c3f169a4f5737b4932b1c8bf573fb19b768015609718a9fee33a07d'
  })

  no_source_build

  depends_on 'buildessential' => :build
  depends_on 'glibc' # R
  depends_on 'py3_docutils' => :build
  depends_on 'python3' # L
  depends_on 'texinfo' => :build
end
