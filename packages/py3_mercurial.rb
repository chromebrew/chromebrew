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
    aarch64: '8a0a22e9b4ff0fe2ed43cc774d0e39e0f20f7abc89ad3f83a6a25848cc0c8bd3',
     armv7l: '8a0a22e9b4ff0fe2ed43cc774d0e39e0f20f7abc89ad3f83a6a25848cc0c8bd3',
     x86_64: '7efa6d66f030e8ec26309d529c34372a4f5b2d78a0eece80c79e88531d57919f'
  })

  depends_on 'buildessential' => :build
  depends_on 'glibc' # R
  depends_on 'py3_docutils' => :build
  depends_on 'python3' # L
  depends_on 'python3' # R
  depends_on 'texinfo' => :build

  no_source_build
end
