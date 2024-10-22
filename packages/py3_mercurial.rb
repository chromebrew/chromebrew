require 'buildsystems/pip'

class Py3_mercurial < Pip
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version "6.8.1-#{CREW_PY_VER}"
  license 'GPL-2+'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2d9cedb67c6faa94bac598b80e459cb32cb42c179bea9f2bfa1bfa333e6924e8',
     armv7l: '2d9cedb67c6faa94bac598b80e459cb32cb42c179bea9f2bfa1bfa333e6924e8',
     x86_64: '13639adc06ece9b10905eb9e532062588b62944348e521b02e2419816f5ff689'
  })

  no_source_build

  depends_on 'buildessential' => :build
  depends_on 'glibc' # R
  depends_on 'py3_docutils' => :build
  depends_on 'python3' # L
  depends_on 'texinfo' => :build
end
