# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.8.6-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '196868d7bddbbb1f438164d09d4ed63c3863d13c389f5df04985f5325a49dd4b',
     armv7l: '196868d7bddbbb1f438164d09d4ed63c3863d13c389f5df04985f5325a49dd4b',
       i686: '44804061c13daccb71f0eadc84ed64a52ad01cdd196464ae9a2f14f7f516254b',
     x86_64: '409e5a18a1f009f4317488ac55c41a1164e68aa81a6314b4b36b38d1880a3158'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
end
