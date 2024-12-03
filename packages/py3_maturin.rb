# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.7.7-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '06f1a37b7864fb8af6baa6d473e945226c0086a1a96bc1cf18edb7c860d66def',
     armv7l: '06f1a37b7864fb8af6baa6d473e945226c0086a1a96bc1cf18edb7c860d66def',
       i686: 'ee8b37da3f76cded261e51bbda254bc199859290d4fb251125be8a37d6cded74',
     x86_64: 'b9c4f0462aa59cde392a1e9e302f6e71a064dfc4c10aedee97d96da54aafb4d1'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
end
