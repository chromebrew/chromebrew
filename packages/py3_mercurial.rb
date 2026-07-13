require 'buildsystems/pip'

class Py3_mercurial < Pip
  description 'Mercurial is a free, distributed source control management tool. It efficiently handles projects of any size and offers an easy and intuitive interface.'
  homepage 'https://www.mercurial-scm.org/'
  version "7.2.3-#{CREW_PY_VER}"
  license 'GPL-2+'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dbd77d49830ac8775183be498eb56aac131dfc201bf74bf8a59b20645236a32b',
     armv7l: 'dbd77d49830ac8775183be498eb56aac131dfc201bf74bf8a59b20645236a32b',
     x86_64: '32b92d48c74f1b701faea9b58acc34ed62d8103865c5b5b8ec5d82f6d7153f24'
  })

  depends_on 'buildessential' => :build
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'py3_docutils' => :build
  depends_on 'python3' => :logical
  depends_on 'texinfo' => :build

  no_source_build
end
