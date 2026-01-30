require 'buildsystems/pip'

class Py3_mercurial < Pip
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version "7.2-#{CREW_PY_VER}"
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '08c871bc53ed4977e46aa6c3ff602643dd16683994198caea4b1c38a6ef810a0',
     armv7l: '08c871bc53ed4977e46aa6c3ff602643dd16683994198caea4b1c38a6ef810a0',
     x86_64: '44007672d101567e1141c40f60039bbc9bc56d3490bbb950ea895f7f182476c6'
  })

  depends_on 'buildessential' => :build
  depends_on 'glibc' # R
  depends_on 'py3_docutils' => :build
  depends_on 'python3' # L
  depends_on 'python3' # R
  depends_on 'texinfo' => :build

  no_source_build
end
