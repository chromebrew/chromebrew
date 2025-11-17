# Adapted from Arch Linux python-rpds-py PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-rpds-py/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_rpds_py < Pip
  description 'Python bindings to the Rust rpds crate for persistent data structures'
  homepage 'https://github.com/crate-py/rpds'
  version '0.29.0'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f1c5d04b16221c8b3650c4b3942c17eef7d4744fa993e50ac27b80620764def4',
     armv7l: 'f1c5d04b16221c8b3650c4b3942c17eef7d4744fa993e50ac27b80620764def4',
       i686: '4de9ce4de21d66e71210e4f5a29db2180dce9172865c4b0f01a566c0c1a118ac',
     x86_64: '7547bcad38e928c966350529a2c03c77b4b2c8125b44fe9ae90680c86d61ac83'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_source_build
end
