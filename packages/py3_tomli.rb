require 'buildsystems/pip'

class Py3_tomli < Pip
  description "Tomli is a lil' TOML parser."
  homepage 'https://github.com/hukkin/tomli/'
  version "2.0.2-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '3eff3d0e02b85620e9d94b05a62cc6045f1d6904d00f4aa3446dde0906a5997a',
     armv7l: '3eff3d0e02b85620e9d94b05a62cc6045f1d6904d00f4aa3446dde0906a5997a',
       i686: 'cd6db6cd66b8ad5cc2eb219b49fe6f4102182971baa1b195307f655658bf68f9',
     x86_64: 'df7a1ef8de474e682ed5a5b96476ff8fd73f95075581c923ef28e3647d505de0'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'

  no_source_build
end
