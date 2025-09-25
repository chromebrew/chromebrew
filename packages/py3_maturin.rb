# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.9.4-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6e1e8e8e3f3de1e532d0b34b138c6790ab21d0f776ca031e1bba5882a66aef15',
     armv7l: '6e1e8e8e3f3de1e532d0b34b138c6790ab21d0f776ca031e1bba5882a66aef15',
       i686: '499f7b0411a6211db7a70d063fd2e0a17b272e26c2e1d399c80f7e750db93af9',
     x86_64: '1e1afeb8573c21bfa76330e952e04ee94b4a3416879d77a8060f524889049e01'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
end
