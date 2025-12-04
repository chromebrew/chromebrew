require 'buildsystems/pip'

class Py3_lxml < Pip
  description 'LXML is a Python library for processing XML and HTML.'
  homepage 'https://lxml.de/'
  version "6.0.2-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8e0e80777656cf59769a7d371716f6c2c0e08a24473f0b3c69acad65e8db3ab2',
     armv7l: '8e0e80777656cf59769a7d371716f6c2c0e08a24473f0b3c69acad65e8db3ab2',
       i686: '6c5d28d333f65582dcf371cb83edd3be629c9a47b34d204b910822efe82421cd',
     x86_64: 'f21867b004d093bdcfa7866d55c63d1da89cbb752a90ce16f4fe80db5354b831'
  })

  depends_on 'glibc' # R
  depends_on 'libxml2' # L
  depends_on 'libxslt' # L
  depends_on 'py3_cython' => :build
  depends_on 'python3' # R
  depends_on 'zlib' # R

  no_source_build
end
