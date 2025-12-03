require 'buildsystems/pip'

class Py3_tomli < Pip
  description "Tomli is a lil' TOML parser."
  homepage 'https://github.com/hukkin/tomli/'
  version "2.3.0-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8a3d6b02ba9e674056895722bfe197d73cfe11757efda8ad67d69cc2c788d086',
     armv7l: '8a3d6b02ba9e674056895722bfe197d73cfe11757efda8ad67d69cc2c788d086',
       i686: 'cf8be7b9a5ea4116887425ef2ea3dda124a77d45a7319cf89ae732654f15afd4',
     x86_64: '6ff386cae040d1b53fc0fbc853faeda1d1baae3e7e385ff16c01ddaffbb4a678'
  })

  depends_on 'glibc' # R
  depends_on 'py3_flit_core'
  depends_on 'python3'

  no_source_build
end
