require 'buildsystems/pip'

class Py3_pyasn1 < Pip
  description 'PyASN.1 is a generic ASN.1 library for Python'
  homepage 'https://github.com/etingof/pyasn1/'
  version '0.6.1-py3.12'
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9d8018adef966ec66cd60f0924e40c773e277d4547ff180a0c04e260dfbe0ac3',
     armv7l: '9d8018adef966ec66cd60f0924e40c773e277d4547ff180a0c04e260dfbe0ac3',
       i686: '76559daf12c78fb394d66c2306cd100ab7d497dd812979d29ace9fa25cda2f4e',
     x86_64: '92860f50de67f848e4262120c4ec53dbd3c507b942968f9ea865defc47380516'
  })

  depends_on 'python3' => :build

  no_source_build
end
