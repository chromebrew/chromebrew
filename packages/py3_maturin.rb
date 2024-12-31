# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.8.1-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '11412ac0a7881d99e2cf3b6ec52c322104f0491660a94771034caa9d982b3f18',
     armv7l: '11412ac0a7881d99e2cf3b6ec52c322104f0491660a94771034caa9d982b3f18',
       i686: 'd02b7e40651f9ef55f2267a94ca37cabfd7e90d949e29d447d645bd3c7c9e3d8',
     x86_64: 'a6826a67abda0f0947cbc85c6e324b7800fa1ba63f69120811c3227f5e6eb5d7'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
end
