require 'buildsystems/pip'

class Py3_click < Pip
  description 'Click is a simple wrapper around optparse for powerful command line utilities.'
  homepage 'https://click.palletsprojects.com'
  version "8.3.2-#{CREW_PY_VER}"
  license 'BSD-3'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '09a208c7f4709231aae4e18d6e4a91d137a90f6b9050133d20cfe2edc9169449',
     armv7l: '09a208c7f4709231aae4e18d6e4a91d137a90f6b9050133d20cfe2edc9169449',
       i686: 'a02b70cd03583a98f31056ff0d5d80a7846636a63cd4e8519c89c332d279ea2d',
     x86_64: 'f95958d725755a7f54dee4b63de172b642a15dde17a247830cf7150578a18a9d'
  })

  depends_on 'python3' => :logical

  no_source_build
end
