# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.14.1-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '9bf4d4a440683f90ca476ee9efe0b9d4c319dc8d68722c3221a25dc6ba6f4cbd',
     armv7l: '9bf4d4a440683f90ca476ee9efe0b9d4c319dc8d68722c3221a25dc6ba6f4cbd',
       i686: 'fa5b32c3f598aa759e2a27ca7565fefec0affd8a11f53c7d94b885a5a4dd8ca8',
     x86_64: '52d3d905d206e41afab91b0342a7ca163c15252e87ee34efb2e7fa3ed4e95b2c'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'py3_semantic_version' => :build
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'python3' => :executable
  depends_on 'python3' => :logical
  depends_on 'rust'
end
