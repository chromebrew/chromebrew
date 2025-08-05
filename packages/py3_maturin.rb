# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.9.3-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '611f30b4202490c74602f70cbbadc131f3b407f75d654039edf807eaa1373f5b',
     armv7l: '611f30b4202490c74602f70cbbadc131f3b407f75d654039edf807eaa1373f5b',
       i686: '483738b36d573c22a0a6c70bde0d1182f0baeba5f72ced1bd82e27df5838dbd0',
     x86_64: 'dc4d8b80a74baa4d8f11abb2f0424c92992a7ce4447b4487c928abce58ff825c'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'

end
