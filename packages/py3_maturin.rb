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
       i686: '38080c9562467aa6fbb7682d01b789aec28dad6d29a6d8f1b064fce1c3fb2c30',
     x86_64: '74ca8a20648507e0b028ce4cc87fde510069f87b50d7d7258af898bcd8950ee9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
end
