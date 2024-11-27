require 'buildsystems/pip'

class Py3_pyopenssl < Pip
  description 'PyOpenSSL is a Python wrapper module around the OpenSSL library.'
  homepage 'https://www.pyopenssl.org/'
  version "24.3.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '01ce9ef5a47d5dee85a8241bd453e3278e655a8238a0e66280926e4aa2f1c2ba',
     armv7l: '01ce9ef5a47d5dee85a8241bd453e3278e655a8238a0e66280926e4aa2f1c2ba',
       i686: '25a91a785492c5700d91107847c649fb8ab0ee173435268d334542628f1e4183',
     x86_64: '6b993b7b0aee67c9ed9dd6657e4ddd47be091fcfc9d774071def35285db01247'
  })

  depends_on 'openssl'
  depends_on 'py3_cryptography'
  depends_on 'py3_six'
  depends_on 'python3' => :build
  depends_on 'rust' => :build

  no_source_build
end
