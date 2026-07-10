require 'buildsystems/pip'

class Py3_pyasn1 < Pip
  description 'PyASN.1 is a generic ASN.1 library for Python'
  homepage 'https://github.com/etingof/pyasn1/'
  version "0.6.4-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '1262b8c100ac7b4dea5862ec2b5058d1e8874207e4171fc5551500e36abf2613',
     armv7l: '1262b8c100ac7b4dea5862ec2b5058d1e8874207e4171fc5551500e36abf2613',
       i686: '04a877fac0c3740da848fb39b3f399bbda98adc7db92d4f1532b77446da2f9b8',
     x86_64: 'fec24f304d64050d3d2ce7f12839ce1160f46a8521ab8e9a3534ed1d9cb98e02'
  })

  depends_on 'python3' => :logical

  no_source_build
end
