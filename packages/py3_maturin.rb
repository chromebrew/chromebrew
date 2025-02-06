# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.8.2-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bd9c40be21c44732d0a61b2b51b0c1c8b271cbfa1124d482657a7efc4b8dc78d',
     armv7l: 'bd9c40be21c44732d0a61b2b51b0c1c8b271cbfa1124d482657a7efc4b8dc78d',
       i686: '7b22905ab31750e2b2b8227b60204e30025d239b48f4548552d3da52d0e51782',
     x86_64: '5bb56d9072ee03a8bbf1906a4c459c22b562092b384588277b3a75b22f8a5976'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
end
