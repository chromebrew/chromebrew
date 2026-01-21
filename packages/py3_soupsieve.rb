require 'buildsystems/pip'

class Py3_soupsieve < Pip
  description 'CSS selector library designed to be used with Beautiful Soup 4.'
  homepage 'https://github.com/facelessuser/soupsieve'
  version "2.8.3-#{CREW_PY_VER}"
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'e92d2e37811e1f4030acb26a63a69cd4e63727d2c60a4e52186e807f41702256',
     armv7l: 'e92d2e37811e1f4030acb26a63a69cd4e63727d2c60a4e52186e807f41702256',
       i686: 'f10c66c5402436cae7593d2702315c7056c5aae9b511185fe89d011b11838a6c',
     x86_64: '7695d0c8adf1e23499762a7a7364634e84363675c3d6dfdbb677dbf0130d599a'
  })

  depends_on 'python3' => :build

  no_source_build
end
