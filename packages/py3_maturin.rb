# Adapted from Arch Linux maturin PKGBUILD at:
# https://gitlab.archlinux.org/archlinux/packaging/packages/maturin/-/blob/main/PKGBUILD?ref_type=heads

require 'buildsystems/python'

class Py3_maturin < Python
  description 'Build and publish crates with pyo3, rust-cpython and cffi bindings'
  homepage 'https://github.com/PyO3/maturin'
  version "1.13.3-#{CREW_PY_VER}"
  license 'Apache-2.0 OR MIT'
  compatibility 'all'
  source_url 'https://github.com/PyO3/maturin.git'
  git_hashtag "v#{version.split('-').first}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '0722b004f00637b4e6abc2499909f66f14807e3447d2507e1db5a96255dbafd1',
     armv7l: '0722b004f00637b4e6abc2499909f66f14807e3447d2507e1db5a96255dbafd1',
       i686: '6578a873d4b325f25c2cd94aca66ed6ef7b0168bdbdd3a6cf2e5b928be37211d',
     x86_64: 'e967183dfdb8f2707f138cae8d75d0e278463e4b8a07a9880e7833282e33d3c4'
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
