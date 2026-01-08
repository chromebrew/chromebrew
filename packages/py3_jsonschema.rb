# Adapted from Arch Linux python-jsonschema PKGBUILD at:
# https://github.com/archlinux/svntogit-community/raw/packages/python-jsonschema/trunk/PKGBUILD

require 'buildsystems/pip'

class Py3_jsonschema < Pip
  description 'An implementation of JSON Schema validation for Python'
  homepage 'https://github.com/python-jsonschema/jsonschema'
  version '4.26.0'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6ee5977604589f45c959aac2c59f43a62861ebf7b87a2666b08736ae723f1946',
     armv7l: '6ee5977604589f45c959aac2c59f43a62861ebf7b87a2666b08736ae723f1946',
       i686: '9ab6489a3b437d090a4ef738fe85e49e9134b18c65c6751cb77952044dd8807b',
     x86_64: '0745d632978887b2b825df535e4b1f25cd2a11433171bbf4456128d5fb0a7249'
  })

  depends_on 'py3_attrs' # R
  depends_on 'py3_jsonschema_specifications' # R
  depends_on 'py3_referencing' # R
  depends_on 'py3_rpds_py' # R
  depends_on 'python3' => :build

  no_source_build
end
