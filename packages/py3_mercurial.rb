require 'buildsystems/pip'

class Py3_mercurial < Pip
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version "7.2.4-#{CREW_PY_VER}"
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd042f005afb1020ba87782a39e30d0e4c61c61642a8db100230a4a2aef15ccf3',
     armv7l: 'd042f005afb1020ba87782a39e30d0e4c61c61642a8db100230a4a2aef15ccf3',
     x86_64: '49db8a2f72361fa6f026499d2f180ae8ddeb729447322e6c93e9e6da35912644'
  })

  depends_on 'buildessential' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'py3_docutils' => :build
  depends_on 'python3' => :logical
  depends_on 'texinfo' => :build

  no_source_build
end
