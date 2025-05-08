require 'buildsystems/pip'

class Py3_mercurial < Pip
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version "7.0.2-#{CREW_PY_VER}"
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4312230438acdd5e46dbf817e1b1cf8b6eac4e389dc4c899fe66430018f971ca',
     armv7l: '4312230438acdd5e46dbf817e1b1cf8b6eac4e389dc4c899fe66430018f971ca',
     x86_64: '784576662e76d19c1c6df9ac0cb8c9c7879c07568f4f92da3cc839973f117aff'
  })

  no_source_build

  depends_on 'buildessential' => :build
  depends_on 'glibc' # R
  depends_on 'py3_docutils' => :build
  depends_on 'python3' # L
  depends_on 'texinfo' => :build
end
