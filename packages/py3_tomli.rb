require 'buildsystems/pip'

class Py3_tomli < Pip
  description "Tomli is a lil' TOML parser."
  homepage 'https://github.com/hukkin/tomli/'
  version "2.5.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f0987ebf32ed8b1bff7088b17d27fde49f60ed04c8cfeafe8efb314c877bfba1',
     armv7l: 'f0987ebf32ed8b1bff7088b17d27fde49f60ed04c8cfeafe8efb314c877bfba1',
       i686: '829065c6bb18834f9f780b15de66c5fc299ff09a8359046b9e29532094b5fac9',
     x86_64: '3ca626cb796c83c6c9f1ede021309d8d3933413a9fc9137fd381bde273ea286c'
  })

  depends_on 'glibc' => :build
  depends_on 'glibc_lib' => :build
  depends_on 'py3_flit_core'
  depends_on 'python3' => :logical

  no_source_build
end
