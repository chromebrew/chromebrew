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
    aarch64: '99536c30cc3e8d6f8856f62bb5fd9d227b57d0be0ed3bf8629c7867a2e7b530a',
     armv7l: '99536c30cc3e8d6f8856f62bb5fd9d227b57d0be0ed3bf8629c7867a2e7b530a',
     x86_64: '86bcc69c121f82ca1f3673acb7098774b56d1cbdbd6cad8171c6511afcd0911e'
  })

  depends_on 'buildessential' => :build
  depends_on 'glibc' # R
  depends_on 'py3_docutils' => :build
  depends_on 'python3' # L
  depends_on 'texinfo' => :build

  no_source_build
end
