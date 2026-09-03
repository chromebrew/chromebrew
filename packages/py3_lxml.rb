require 'buildsystems/pip'

class Py3_lxml < Pip
  description 'LXML is a Python library for processing XML and HTML.'
  homepage 'https://lxml.de/'
  version "6.1.3-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c2a9d5bc43e22f3f82813e3045554497329343a835cdafac0fc38b384a16067',
     armv7l: '6c2a9d5bc43e22f3f82813e3045554497329343a835cdafac0fc38b384a16067',
       i686: '28455fac1a8ffbad70b411a1527862b2f059cdd33d96eca20992bcc0f5a3e256',
     x86_64: '8af3deafaa5961d3a80d4533707669401d94ac613d8fb4dc69bdcd5f5f0326a0'
  })

  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'libxml2' => :library
  depends_on 'libxslt' => :library
  depends_on 'py3_cython' => :build
  depends_on 'python3' => :logical
  depends_on 'zlib' => :library

  no_source_build
end
