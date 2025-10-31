# Adapted from Arch Linux python-jsonschema-specifications PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-jsonschema-specifications/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_jsonschema_specifications < Pip
  description 'The JSON Schema meta-schemas and vocabularies, exposed as a Registry'
  homepage 'https://github.com/python-jsonschema/jsonschema-specifications'
  version '2025.9.1'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '19dd0337bd455d9bbb0368ceae8a24627ca64e3034d71cfb52d0b7a169c32d51',
     armv7l: '19dd0337bd455d9bbb0368ceae8a24627ca64e3034d71cfb52d0b7a169c32d51',
       i686: '1146832c3501207707c8b4ade246a58ae7ad1f95dfcfebfa738f6706d3106325',
     x86_64: '8949c48681d96dd7c2d1910f991c9dd5cc9776f37994a166674ffd58dfc434a2'
  })

  depends_on 'py3_referencing' # R
  depends_on 'python3' => :build

  no_source_build
end
