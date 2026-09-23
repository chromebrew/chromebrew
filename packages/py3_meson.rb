require 'buildsystems/pip'

class Py3_meson < Pip
  description 'Meson is an open source build system meant to be both extremely fast and user friendly.'
  homepage 'https://mesonbuild.com/'
  version "1.12.1-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f3112dcab0ee8c7612b21ade8f3760389f80a2dc11e90808d8923bd8c2e89189',
     armv7l: 'f3112dcab0ee8c7612b21ade8f3760389f80a2dc11e90808d8923bd8c2e89189',
       i686: '9b8184ebabca456c6bca57b28acc4e168075fecee579b7879a905eb015913248',
     x86_64: 'e7dc2c49607f4d5529732154c55644489ae2e61b2a88f4af7f8abc3495f4c19b'
  })

  depends_on 'ninja'
  depends_on 'python3'
  depends_on 'python3' => :logical

  no_source_build
end
