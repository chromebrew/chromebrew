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
     x86_64: '1e70496d9a31f5bc7f8c27e698dfabaa63c3eebe0293c8b0a24e083ff6fafe11'
  })

  no_source_build

  depends_on 'buildessential' => :build
  depends_on 'glibc' # R
  depends_on 'py3_docutils' => :build
  depends_on 'python3' # L
  depends_on 'texinfo' => :build
end
