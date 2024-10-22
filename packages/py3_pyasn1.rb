require 'buildsystems/pip'

class Py3_pyasn1 < Pip
  description 'PyASN.1 is a generic ASN.1 library for Python'
  homepage 'https://github.com/etingof/pyasn1/'
  version "0.6.1-#{CREW_PY_VER}"
  license 'BSD-2'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '172da797ac6550fb12eb8a7cc90db8b88e2be8a7b270d9d375f0a1dfeab44178',
     armv7l: '172da797ac6550fb12eb8a7cc90db8b88e2be8a7b270d9d375f0a1dfeab44178',
       i686: 'dd2b51fe843008b5728327a201c462b76adca2f3da012323c184237f2990fcbd',
     x86_64: '7cf592e5dada02001c17e3588a004f6e0340c22fb38fa57388909b85b3ac1a95'
  })

  depends_on 'python3' => :build

  no_source_build
end
