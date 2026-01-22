require 'buildsystems/pip'

class Py3_sqlalchemy < Pip
  description 'SQLalchemy is a database toolkit for Python.'
  homepage 'https://sqlalchemy.org'
  version "2.0.46-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fe6f647f4c1d649a5d2d47b47db330c27720b29e429a66ccd8f8e8fceb5f9735',
     armv7l: 'fe6f647f4c1d649a5d2d47b47db330c27720b29e429a66ccd8f8e8fceb5f9735',
       i686: 'e9a963251a205932a678f1572e0af6ea32b2a56ac311893341a1b12a6a8a8b75',
     x86_64: '8bc2b681b5cc9889bda45f5da6d075190cbf0806e7c12b07fe6dd14e39d026be'
  })

  depends_on 'glibc' # R
  depends_on 'python3' # R

  no_source_build
end
