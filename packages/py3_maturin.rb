# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.9.5-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b21d007df4cf46c2ef3320aaf039e9fcdd045e5899000246f7e39303cf0e7673',
     armv7l: 'b21d007df4cf46c2ef3320aaf039e9fcdd045e5899000246f7e39303cf0e7673',
       i686: '732e55300c6d7e7c282d7e895660de42c5cb2e95d05b02698c8be97822bf6e25',
     x86_64: 'dbdf74ff3cbe1947eecd9a74e57b5e6fc55585ede1abd55d4e0ab5ddd8ab5ef0'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
end
