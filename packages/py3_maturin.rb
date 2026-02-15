# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.12.0-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '8fd2a44569efb537ca59f732033fbdf6783cdfe48b852e7d94dde100ce244675',
     armv7l: '8fd2a44569efb537ca59f732033fbdf6783cdfe48b852e7d94dde100ce244675',
       i686: '0f443beb263198c931463dc6e5f4924626edf4106ff92e0f4679c50b3e48cd78',
     x86_64: '8ec407aa45623c85407361d465f5da6f4c8094d58b75eb620fd4b9f10253f8f8'
  })

  depends_on 'gcc_lib' => :executable_only
  depends_on 'glibc' => :executable_only
  depends_on 'py3_semantic_version' => :build
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'python3' => :executable_only
  depends_on 'rust'
end
