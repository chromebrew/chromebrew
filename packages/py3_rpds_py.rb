# Adapted from Arch Linux python-rpds-py PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/python-rpds-py/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_rpds_py < Pip
  description 'Python bindings to the Rust rpds crate for persistent data structures'
  homepage 'https://github.com/crate-py/rpds'
  version '0.28.0'
  license 'MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '42a10684f12b9ac16ea2a2e086f20c67d4d7ceeaaedcaa5e12aef2e2f1e2a704',
     armv7l: '42a10684f12b9ac16ea2a2e086f20c67d4d7ceeaaedcaa5e12aef2e2f1e2a704',
       i686: '3cfca998d523196ec38030db35590721211bfe34d11f5ad0f1fe7b01f9d3a75a',
     x86_64: 'b567f1b562155f93badca2cde1a596d68c865e380a85ba7d6e1d7a04ac658298'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'python3' # R
  depends_on 'rust' => :build

  no_source_build
end
