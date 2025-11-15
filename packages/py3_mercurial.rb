require 'buildsystems/pip'

class Py3_mercurial < Pip
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version "7.1.2-#{CREW_PY_VER}"
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f24f981567d9f27dea5e3fe922fd3705cbb1b2d5f1162780e78bcf9ea4a12143',
     armv7l: 'f24f981567d9f27dea5e3fe922fd3705cbb1b2d5f1162780e78bcf9ea4a12143',
     x86_64: 'ca58323ce7be93b658f2ac4f29c109e39d49a0cf37d845c8344d5467689e589f'
  })

  depends_on 'buildessential' => :build
  depends_on 'glibc' # R
  depends_on 'py3_docutils' => :build
  depends_on 'python3' # L
  depends_on 'python3' # R
  depends_on 'texinfo' => :build

  no_source_build
end
