require 'buildsystems/pip'

class Py3_greenlet < Pip
  description 'Greenlet provides lightweight in-process concurrent programming.'
  homepage 'https://greenlet.readthedocs.io/'
  version "3.2.4-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '762bcd6c1c2ed7376d7630cab0d9e573df8dafd47ae98c17543cc9f116db5045',
     armv7l: '762bcd6c1c2ed7376d7630cab0d9e573df8dafd47ae98c17543cc9f116db5045',
       i686: 'fe87ea90f7cc54a5b47877b8a14c521b7df0fad5bcdb0a93aa74bf05952daf8c',
     x86_64: 'b1f6d523679640321354cba7bc010d116c8c2232a3a69ec4d02d31b1b2bf24d5'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_agate'
  depends_on 'py3_sqlalchemy'
  depends_on 'python3' => :build

  no_source_build
end
