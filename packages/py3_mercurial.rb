require 'buildsystems/pip'

class Py3_mercurial < Pip
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version '6.7.4'
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c85013c1f2fea8cc5c07f6e66d73a99abe527cc7a0529b53a504d7b865cf9d29',
     armv7l: 'c85013c1f2fea8cc5c07f6e66d73a99abe527cc7a0529b53a504d7b865cf9d29',
     x86_64: 'c408b753a4a7b271ec69d971494bcca92f30b53425fbb12ebc7b758569f908ee'
  })

  no_source_build

  depends_on 'buildessential' => :build
  depends_on 'glibc' # R
  depends_on 'py3_docutils' => :build
  depends_on 'python3' # L
  depends_on 'texinfo' => :build
end
