require 'buildsystems/pip'

class Py3_imagesize < Pip
  description 'Imagesize gets image size from png/jpeg/jpeg2000/gif file.'
  homepage 'https://github.com/shibukawa/imagesize_py/'
  version "2.0.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd9aad80d2a3894540ecdbb71910f8e4140c8dd06d5c73fe8612767f55cb8ffd7',
     armv7l: 'd9aad80d2a3894540ecdbb71910f8e4140c8dd06d5c73fe8612767f55cb8ffd7',
       i686: '4747dd9aa5f322029da478e62bfa56173e261e12035d277d7cb370822ca10cd6',
     x86_64: 'e256428d30858caa6a0f28e674871ad481606c37e5d2ddc890860d199ef1fefd'
  })

  depends_on 'python3' => :logical

  no_source_build
end
