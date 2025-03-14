# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.8.3-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ee3f99b0865596a1520d333c94e7a5ca9d7f74f82c439b7f1a78551b99d758aa',
     armv7l: 'ee3f99b0865596a1520d333c94e7a5ca9d7f74f82c439b7f1a78551b99d758aa',
       i686: 'f7b2f5b2b3fd7450dd1067d52bcb6034d624f550b26fcb4c204742fc7e032d94',
     x86_64: 'bf23fc476f8650a51198c0655f3983c9d7072f16fbf0bff6cda6b9c133b2efa1'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
end
