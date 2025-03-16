require 'buildsystems/pip'

class Py3_pycryptodome < Pip
  description 'Pycryptodome is a cryptographic library for Python.'
  homepage 'https://www.pycryptodome.org/'
  version "3.22.0-#{CREW_PY_VER}"
  license 'BSD and public-domain'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'da636cc4e3d65059fd43d6560b42ce5beaaa8312c83166275b2654159f525b55',
     armv7l: 'da636cc4e3d65059fd43d6560b42ce5beaaa8312c83166275b2654159f525b55',
       i686: 'f01ef414c34ef3ea2431720f38881c3dc5a5e6bba718c53c32c79afbec2d5a53',
     x86_64: '2d60dc2b798d690a7b5689b4a71375437f46d2f6b596fbd7af8673b7bd36db55'
  })

  depends_on 'glibc' # R
  depends_on 'python3' => :build

  no_source_build
end
