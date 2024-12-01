# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.7.6-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '06f1a37b7864fb8af6baa6d473e945226c0086a1a96bc1cf18edb7c860d66def',
     armv7l: '06f1a37b7864fb8af6baa6d473e945226c0086a1a96bc1cf18edb7c860d66def',
     x86_64: '62ba08658e8d09f0b46cff6a70610ea43bcc364d73a98b54ac0de147b18cb50a'
  })

  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
end
