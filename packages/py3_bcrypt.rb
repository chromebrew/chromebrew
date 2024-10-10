require 'buildsystems/pip'

class Py3_bcrypt < Pip
  description 'Modern password hashing for your software and your servers.'
  homepage 'https://github.com/pyca/bcrypt/'
  version "4.2.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9a83c9a28d1c842577e5c89e96eb69bc0080f3492c4602b77275dfb3a24b2c31',
     armv7l: '9a83c9a28d1c842577e5c89e96eb69bc0080f3492c4602b77275dfb3a24b2c31',
       i686: 'bc5509af909c37d88226ebd0d3fbe938d6d22713f34cbe6f25e1409ee6f63fe5',
     x86_64: 'd60c1762dce34b0fbc88f8d4c2eb191ea75d091e0487f7caef6e0dbd468f588f'
  })

  depends_on 'python3'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'rust' => :build

  no_source_build
end
