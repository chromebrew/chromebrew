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
       i686: '3441cfda02d83fbdac8036a196cccac1d36b2c2acbfd2775a5f0b42d96271b67',
     x86_64: '961c95392fd82b1f5f0e16d38f9b1ece5eaac22a82a0c1e25aa9c36164a54c6a'
  })

  depends_on 'python3'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'rust' => :build

  no_source_build
end
