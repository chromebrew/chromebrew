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
       i686: '68f8cd4613ecde5779ad00075f5627bf272b500a97e9427f46c4f9a055de27d4',
     x86_64: '9691384441df837f7fd26b7b303c454e456fff76ad2549a458bf5874a00ae541'
  })

  depends_on 'python3'
  depends_on 'py3_flit_core'
  depends_on 'glibc' # R

  no_source_build
end
