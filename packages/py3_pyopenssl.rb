require 'buildsystems/pip'

class Py3_pyopenssl < Pip
  description 'PyOpenSSL is a Python wrapper module around the OpenSSL library.'
  homepage 'https://www.pyopenssl.org/'
  version "26.4.0-#{CREW_PY_VER}"
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6c5ee5f2f3c0992e564a5925dd651c0bd49456414381aace382f4973f06fcd42',
     armv7l: '6c5ee5f2f3c0992e564a5925dd651c0bd49456414381aace382f4973f06fcd42',
       i686: 'b45131d866d88b6e7bae85bf1a6d12c918e80fff91ad7e9598a0c04574b2501a',
     x86_64: '4fae7ebfb56e158fabb273b40baa82ce6cc7bf13a9302fa7b04c433369129ae8'
  })

  depends_on 'openssl'
  depends_on 'py3_cryptography'
  depends_on 'py3_six'
  depends_on 'python3' => :logical
  depends_on 'rust' => :build

  no_source_build
end
