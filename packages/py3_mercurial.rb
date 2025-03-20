require 'buildsystems/pip'

class Py3_mercurial < Pip
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version "6.9.4-#{CREW_PY_VER}"
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd87fdd561582144f4d8f8d5b4af05d527efede7504425904915de79be8c9a262',
     armv7l: 'd87fdd561582144f4d8f8d5b4af05d527efede7504425904915de79be8c9a262',
     x86_64: '1d79cf74facbd89c2c8a117876a8864519f604559b1fa5f5f55107c9c122a733'
  })

  no_source_build

  depends_on 'buildessential' => :build
  depends_on 'glibc' # R
  depends_on 'py3_docutils' => :build
  depends_on 'python3' # L
  depends_on 'texinfo' => :build
end
