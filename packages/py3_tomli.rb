require 'buildsystems/pip'

class Py3_tomli < Pip
  description "Tomli is a lil' TOML parser."
  homepage 'https://github.com/hukkin/tomli/'
  version "2.4.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5dee819acaab7298b61c9e8ab70ced358f1ae0b5c70ee40ca0005d4e8b52412f',
     armv7l: '5dee819acaab7298b61c9e8ab70ced358f1ae0b5c70ee40ca0005d4e8b52412f',
       i686: '3fae346774d00ec1bb2cd29a5ae65540c05995dee0bfd6fb7e51b1e3fb28deff',
     x86_64: 'ddc3d47133e68744145383bd73d78c5f0efddfccefa47eba4166e5e2cd97f9fc'
  })

  depends_on 'glibc' # R
  depends_on 'py3_flit_core'
  depends_on 'python3'

  no_source_build
end
