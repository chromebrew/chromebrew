# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.10.2-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2d8adb85e77974a6aa3a068b1ddc20ea24cfe31a985cba863e4651709f117130',
     armv7l: '2d8adb85e77974a6aa3a068b1ddc20ea24cfe31a985cba863e4651709f117130',
       i686: 'cc609758e479b4961822d071ea76b3dcdc215b7d050d5a3e321921d860036ced',
     x86_64: '653b739a7b867e44c69b3c67928bf5238997efdfb91f8a7970e5b0fe5a2847e9'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_semantic_version' => :build
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
end
