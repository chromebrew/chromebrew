# Adapted from Arch Linux python-rpds-py PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-rpds-py/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_rpds_py < Pip
  description 'Python bindings to the Rust rpds crate for persistent data structures'
  homepage 'https://github.com/crate-py/rpds'
  version '0.30.0'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ae4e9c5131bbd302e75b6658168d9e64356184d4be440a54e46c43cc5698c49b',
     armv7l: 'ae4e9c5131bbd302e75b6658168d9e64356184d4be440a54e46c43cc5698c49b',
       i686: '1febb1c7a436e22d22775e023a8b887a36e121d209b0891aa5c5c95edb94cbe3',
     x86_64: 'f59a3a5d91befbbb8dd9deb7f7010755bb45ea3530ea4558ca5c2eae7ebff363'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_source_build
end
