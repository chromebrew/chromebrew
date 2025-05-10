# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.8.4-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b29b46e5062ba83d98e4345283a29c9d428799f44df6ab76adfc62ed194911be',
     armv7l: 'b29b46e5062ba83d98e4345283a29c9d428799f44df6ab76adfc62ed194911be',
       i686: 'ee14da1d7b4a808996e9650af6f17e60b098f8c94b209687ef4d172e8419d804',
     x86_64: '74ca8a20648507e0b028ce4cc87fde510069f87b50d7d7258af898bcd8950ee9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
end
