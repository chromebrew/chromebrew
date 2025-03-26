require 'buildsystems/pip'

class Py3_mercurial < Pip
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version "7.0-#{CREW_PY_VER}"
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'eb43300563da4e596ed52e16913f9f158df9fde93cb9bc3ea32dcc60bad4bafb',
     armv7l: 'eb43300563da4e596ed52e16913f9f158df9fde93cb9bc3ea32dcc60bad4bafb',
     x86_64: '7fbae567830817df41010a18cdae2a57fe0ecbe966f0fa12dbb6e4402e6f7529'
  })

  no_source_build

  depends_on 'buildessential' => :build
  depends_on 'glibc' # R
  depends_on 'py3_docutils' => :build
  depends_on 'python3' # L
  depends_on 'texinfo' => :build
end
