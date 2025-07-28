# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.9.2-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '805368b610892aba2587f7d2313d0b0e82506f83e86a5171d5a3b6b39e1740cd',
     armv7l: '805368b610892aba2587f7d2313d0b0e82506f83e86a5171d5a3b6b39e1740cd',
       i686: 'aa960a8ea7695b5d45f2e97358f63fa10aa96e3efc1b8725967449d3720e7b93',
     x86_64: 'da9da3e32b9efc1347dde9bc5f43af4a1eb7276c23ed4257929de6f1b5577f63'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
end
