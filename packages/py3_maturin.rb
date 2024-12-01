# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/pip'

class Py3_maturin < Package
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version '1.7.6'
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'SKIP'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '838c0e680136266463abc14b26c86acc0cccd76f0c036d7cb9e9a24771718f82',
     armv7l: '838c0e680136266463abc14b26c86acc0cccd76f0c036d7cb9e9a24771718f82',
       i686: 'c069bec3751bdc9169b66ed03a625f3fa54342ebbf8afd325e92e973ab30ad34',
     x86_64: '0b3cc62c4f2ff1e65186d619fcab0c218fc50fb5877606e8dbbfac1dffa90701'
  })

  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'

  no_source_build
end
