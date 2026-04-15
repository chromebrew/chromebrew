require 'buildsystems/pip'

class Py3_packaging < Pip
  description 'Packaging provides core utilities for Python packages'
  homepage 'https://packaging.pypa.io/'
  version "26.1-#{CREW_PY_VER}"
  license 'BSD-2 or Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '987c3f6606772c9c090df0ccc0fbab0a1c05ce9f036bc27ebd378cb3e104c00a',
     armv7l: '987c3f6606772c9c090df0ccc0fbab0a1c05ce9f036bc27ebd378cb3e104c00a',
       i686: 'f62b4f7dfd537f46ffd82be4ed274bdd8ad75d04b5b758c4e1f42beaabb19894',
     x86_64: '106a43625cfdce3ac2b1086c4bfa0a5c6f48c19ad8388a063621d160a507f657'
  })

  depends_on 'py3_pyparsing'
  depends_on 'python3' => :logical

  no_source_build
end
