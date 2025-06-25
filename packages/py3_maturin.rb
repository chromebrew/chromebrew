# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.9.0-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '63a001ad5ed6050e65d8571f2ea321709ea9400767c5da8a37999dae14cbdb75',
     armv7l: '63a001ad5ed6050e65d8571f2ea321709ea9400767c5da8a37999dae14cbdb75',
       i686: '8287cd7c7fd8ce6b7ec8a2dac920d0b38e28f3c6dbab1cdea7420af44558e8dc',
     x86_64: 'b7d33f7576d34eac5f64cdb80573d56a11d5e56d66bdba34fe3019a4766b1522'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
end
