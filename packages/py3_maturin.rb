# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.10.1-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '4768a315f735b3139b67540544a5453a943e1273b1591a1eba9d7ca6d944d405',
     armv7l: '4768a315f735b3139b67540544a5453a943e1273b1591a1eba9d7ca6d944d405',
       i686: '21fd241e4d4d80b73065dd610c336014f0b791e40ba20df7b911c2f8f0ab25af',
     x86_64: 'b1923d2c29a43070b62599d8f30807aa411f98d6d20eec8eb20c2dd7ef061997'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
end
