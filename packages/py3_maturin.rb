# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.7.8-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'cdb5c19bdca56763e84feb8ffc9329b4fc6fa2b3949019b3c6293d81ee23cd59',
     armv7l: 'cdb5c19bdca56763e84feb8ffc9329b4fc6fa2b3949019b3c6293d81ee23cd59',
       i686: 'cfb1016df5cc47ed9eb846c2ccde844152ecc732b43910a1c24b5499a5a24495',
     x86_64: 'b9c4f0462aa59cde392a1e9e302f6e71a064dfc4c10aedee97d96da54aafb4d1'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
end
