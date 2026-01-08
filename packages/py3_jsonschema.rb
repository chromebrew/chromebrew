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
    aarch64: 'f1e8f97715eb139e47581397f6b54e564b497bf59c4ab7cb5ed079a968925a79',
     armv7l: 'f1e8f97715eb139e47581397f6b54e564b497bf59c4ab7cb5ed079a968925a79',
       i686: 'dc63703998068acfeee7deb7df9a638868ee93861ab81f9a77de503d602cc0b2',
     x86_64: 'ba695cd9de46b094204de75c163198430258953aa2b605b36bed7eda1e2cafd0'
  })

  depends_on 'py3_attrs' # R
  depends_on 'py3_jsonschema_specifications' # R
  depends_on 'py3_referencing' # R
  depends_on 'py3_rpds_py' # R
  depends_on 'python3' => :build

  no_source_build
end
