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
    aarch64: 'b0e8a055ac420f238466ab9ae1a5913f46bda2a2c1ee297b8618c54bea2bd33f',
     armv7l: 'b0e8a055ac420f238466ab9ae1a5913f46bda2a2c1ee297b8618c54bea2bd33f',
       i686: 'aa16733777beda77813010a3ca6cda4d8d900318252ca5aa69938cafd7ac7392',
     x86_64: 'ff908376f7467bb6dc1836de65b3d2f094b4b6e975219481c476d743a89ad694'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_semantic_version' => :build
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
end
