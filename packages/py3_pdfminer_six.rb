require 'buildsystems/pip'

class Py3_pdfminer_six < Pip
  description 'PDFminer.six is a community maintained fork of PDFminer.'
  homepage 'https://pdfminersix.readthedocs.io/'
  version "20250416-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7ea58102874f9dcbffc82685dd690e9965120faabdc2f2f1bfb68ae584b4c652',
     armv7l: '7ea58102874f9dcbffc82685dd690e9965120faabdc2f2f1bfb68ae584b4c652',
       i686: '1e41dca40b419fd91a32f1ca7ca8eac5ad0cbe0963fc36e12a8b059c6a27669d',
     x86_64: 'ba1d8d4997d5cee989b721974570e03908f997a153161b3dfac5a457c56a5e80'
  })

  depends_on 'py3_pycryptodome'
  depends_on 'py3_sortedcontainers'
  depends_on 'python3' => :build

  no_source_build
end
