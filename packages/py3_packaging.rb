require 'buildsystems/pip'

class Py3_packaging < Pip
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  version "25.0-#{CREW_PY_VER}"
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c4011545df1fbced834abcc058c8c5ca5ee50f4fa6f5c5afd3188bda5bf88914',
     armv7l: 'c4011545df1fbced834abcc058c8c5ca5ee50f4fa6f5c5afd3188bda5bf88914',
       i686: 'ed2a4ecd927e923ea8ac8751398ba48524687bb0b57ec10097e17e8d08d0348e',
     x86_64: 'af622c1f2ea85ff29b9e4a9de217f778135d62d71de8e8c64473572b21e2acd1'
  })

  depends_on 'py3_pyparsing'
  depends_on 'python3'

  no_source_build
end
