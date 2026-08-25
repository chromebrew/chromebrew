# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.15.0-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'a811ab6fd09cbae2f17b5ec1524ab8f897ee814935febfd817268d03d4e856c2',
     armv7l: 'a811ab6fd09cbae2f17b5ec1524ab8f897ee814935febfd817268d03d4e856c2',
       i686: '4c5e223af202c2d972e8b640a3306ea9c230b358fff10d507b0f5e90d9d7ec2d',
     x86_64: 'be34717739cd120adceddb3005d239ec77ad12efbf95dc35aa8b7fee81b8f6f7'
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
