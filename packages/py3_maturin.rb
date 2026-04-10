# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.13.1-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '6d6a16affe1a0e3a66d905f2a62376b51ea318f29578bff5fe65f814cb34e960',
     armv7l: '6d6a16affe1a0e3a66d905f2a62376b51ea318f29578bff5fe65f814cb34e960',
       i686: '8a2ea800d1ff32baf80e0742b63a1189f1d972dec6cbae6dc64ee9313cf54e0f',
     x86_64: 'bb39fc9e274c4b22de259a27815cc4a783b3f6485772e7542b12ea1d4cd40a9b'
  })

  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'py3_semantic_version' => :build
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'python3' => :executable
  depends_on 'python3' => :logical
  depends_on 'rust'
end
