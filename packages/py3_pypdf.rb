require 'buildsystems/pip'

class Py3_pypdf < Pip
  description 'A pure-python PDF library capable of splitting, merging, cropping, and transforming the pages of PDF files.'
  homepage 'https://github.com/py-pdf/pypdf'
  version "5.3.1-#{CREW_PY_VER}"
  license 'BSD-3-Clause'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '25dcc3f26c17772ee55fddd92a1f6ea75147a23a234ea92ad9f265acbbb3803c',
     armv7l: '25dcc3f26c17772ee55fddd92a1f6ea75147a23a234ea92ad9f265acbbb3803c',
       i686: '44f1819bd4d9460bd3b33c6d58e8bc8ecbebe9a66d67be7bef9aae156edbb0d5',
     x86_64: '825253abcaa90bd8c0f4183a2a3a5aa948ba65fd66849f6bf63e2124ff0b686b'
  })

  depends_on 'python3'

  no_source_build
end
