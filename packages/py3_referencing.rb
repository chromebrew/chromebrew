# Adapted from Arch Linux python-referencing PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-referencing/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_referencing < Pip
  description 'An implementation-agnostic implementation of JSON reference resolution'
  homepage 'https://referencing.readthedocs.io'
  version '0.37.0'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a90f4481467f54f6f69c8d81001187b4c4f8c28306e5ca00776c5f8cc9c406ff',
     armv7l: 'a90f4481467f54f6f69c8d81001187b4c4f8c28306e5ca00776c5f8cc9c406ff',
       i686: '8ca58219750fe5271285080685aca12af1409a8c14330f3f77fadd931ee2ac97',
     x86_64: 'dd3b1588d03a1873dcc5c64a5a8f96c611b535623ea573b8304d14049de91b50'
  })

  depends_on 'py3_attrs' # R
  depends_on 'py3_rpds_py' # R
  depends_on 'python3' => :build

  no_source_build
end
