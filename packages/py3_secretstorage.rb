require 'buildsystems/pip'

class Py3_secretstorage < Pip
  description 'Python bindings to Freedesktop.org Secret Service API'
  homepage 'https://secretstorage.readthedocs.io/'
  version "3.3.3-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c21ec5de02b7874adf6746995e1247298957895e885deb360d75319f560efa77',
     armv7l: 'c21ec5de02b7874adf6746995e1247298957895e885deb360d75319f560efa77',
       i686: '44d6d4e58dcb10f5e9ac6526afe2734e293490296c3652f0ff995c0d3f28be6d',
     x86_64: 'dfc9f2bf6b1202e0bf917f19795755204de57ec91dc172e51ecf63d75af533b0'
  })

  depends_on 'py3_jeepney'
  depends_on 'py3_cryptography'
  depends_on 'python3' => :build

  no_source_build
end
