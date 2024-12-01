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
    aarch64: '10c452d5a74b1810ec56c42bb722593ae076ff743f1f33bf5aca63cedb7b15c6',
     armv7l: '10c452d5a74b1810ec56c42bb722593ae076ff743f1f33bf5aca63cedb7b15c6',
       i686: 'a280c4b575a7bbda4e4b09b9fda573da64b8c774f01eb8b12e83bc331d97800b',
     x86_64: '0b3cc62c4f2ff1e65186d619fcab0c218fc50fb5877606e8dbbfac1dffa90701'
  })

  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'

  no_source_build
end
