require 'buildsystems/pip'

class Py3_pdfminer_six < Pip
  description 'PDFminer.six is a community maintained fork of PDFminer.'
  homepage 'https://pdfminersix.readthedocs.io/'
  version "20250506-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dbedb2942ccfa689b2745daa677560e5d9434f445706f7ca056b7c4bc7167e43',
     armv7l: 'dbedb2942ccfa689b2745daa677560e5d9434f445706f7ca056b7c4bc7167e43',
       i686: '7b850a6781d2bcaa750d0503da37c9cc281ba19bb88a7cddef8cc05f620fa3d1',
     x86_64: 'c4ee334f8123f3a3ffb6f8ff52f49e3b50cc9760f28b9c2e1f78fa3c459c0778'
  })

  depends_on 'py3_pycryptodome'
  depends_on 'py3_sortedcontainers'
  depends_on 'python3' => :build

  no_source_build
end
