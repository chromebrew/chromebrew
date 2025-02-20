require 'buildsystems/pip'

class Py3_mercurial < Pip
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version "6.9.2-#{CREW_PY_VER}"
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fc41ae969e32319199fd370ab761f8f319db0db28f3d4942ddfaa3f328cb69aa',
     armv7l: 'fc41ae969e32319199fd370ab761f8f319db0db28f3d4942ddfaa3f328cb69aa',
     x86_64: '69c045c9ddb7531f039c73d1cc66f0b269a1692fb0f2623f94aa5b94a2626289'
  })

  no_source_build

  depends_on 'buildessential' => :build
  depends_on 'glibc' # R
  depends_on 'py3_docutils' => :build
  depends_on 'python3' # L
  depends_on 'texinfo' => :build
end
