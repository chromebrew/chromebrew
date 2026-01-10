# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.11.5-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bced1a5aac3af33687b250d123d1a3ddc0da81979ee03c1f4530d3297ce0a864',
     armv7l: 'bced1a5aac3af33687b250d123d1a3ddc0da81979ee03c1f4530d3297ce0a864',
       i686: '1ff2ad3e80acd46bd0844b0d17fda325369699509096ee5ab5b2ae73bc96eb21',
     x86_64: '199e72de4921d004f893d6ca9c9ce4eae0d6734056ca55a43c790ec310c73983'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_semantic_version' => :build
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
end
