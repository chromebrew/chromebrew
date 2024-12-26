# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.8.0-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '69adc844928a159713a25c93f47fb9c9d5a7912a597c4275d2c6de2d5de3ca30',
     armv7l: '69adc844928a159713a25c93f47fb9c9d5a7912a597c4275d2c6de2d5de3ca30',
       i686: '719ff6e58941846d3e6a6b6b65a4142426ffdb989a8c43637821bae03fa996bf',
     x86_64: '0fbde7a51e7e5fe8778fd1da10544282a108fa64fc2d5d2d2d91ea5761ce389c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
end
