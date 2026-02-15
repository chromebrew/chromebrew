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
    aarch64: '63b85a8dfa696fcc3d9784d18ad292ad6876cdda5b457d414c358cc485bd6b07',
     armv7l: '63b85a8dfa696fcc3d9784d18ad292ad6876cdda5b457d414c358cc485bd6b07',
       i686: 'd0c855918012cb2eb66e0d62945de82fa2c97a5ae8487da8d30a70cdbe82f897',
     x86_64: '0abdaf3aa53b4688a00183a74d564db8b4979efdc9b9bf03086b29638ce075ff'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'py3_semantic_version' => :build
  depends_on 'py3_setuptools'
  depends_on 'py3_setuptools_rust'
  depends_on 'python3'
  depends_on 'rust'
end
