require 'buildsystems/pip'

class Py3_lxml < Pip
  description 'LXML is a Python library for processing XML and HTML.'
  homepage 'https://lxml.de/'
  version "6.0.4-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '45a1be8d07ce6c4b444dd5f72dce75c8942fa554c6b233646fe84c40ad2080f6',
     armv7l: '45a1be8d07ce6c4b444dd5f72dce75c8942fa554c6b233646fe84c40ad2080f6',
       i686: 'cc4c6f68415b73497c852b087802ef283df2126cb88e7de2230266c3105da9b8',
     x86_64: '91f92967785652595448a73d6c41ca359ff683d480d420a9b6cc9afd0c64e1e5'
  })

  depends_on 'glibc' => :library
  depends_on 'libxml2' => :library
  depends_on 'libxml2_autotools' => :library
  depends_on 'libxslt' => :library
  depends_on 'py3_cython' => :build
  depends_on 'python3' => :logical
  depends_on 'zlib' => :library

  no_source_build
end
